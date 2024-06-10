import UIKit
import SwiftUI
import Combine
class HomeViewController: BaseViewController {
    private var homeView = HomeView(frame: .zero)
    private var viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    private var currentUser: User?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = homeView

        homeView.addNewBankCard = { [weak self] in
            let addCard = UIHostingController(rootView: AddCardView(viewModel: AddCardViewModel(repository: BankCardRepositoryImpl(localService: LocalBankCardService(), remoteService: RemoteBankCardService()))))
            self?.navigationController?.pushViewController(addCard, animated: true)
        }
        let manager = CurrencyNetworkingManager()
        manager.obtainCoins { result in
            switch result {
            case .success(let coin):
                // Обрабатываем успех
                print("Полученные данные: \(coin)")
            case .failure(let error):
                // Обрабатываем ошибку
                print("Ошибка: \(error)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bindViewModel()
    }

    private func setupNavBar() {
        let userName = UserDefaultsManager.shared.getUserName()
        navigationItem.title = "Привет \(userName), с возвращеним 👋"

        let userVatar = homeView.avatarImage
        let barButtonItem = UIBarButtonItem(customView: userVatar)
        navigationItem.leftBarButtonItem = barButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBankCards()
        viewModel.setCurrentUser()
        if let user = currentUser {
            homeView.configure(user: user)
        }
    }

    private func bindViewModel() {
        viewModel.$bankCards
            .sink { [weak self] bankCards in
                self?.homeView.bankCards = bankCards
                self?.homeView.bankCardCollection.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$currencies
            .sink { [weak self] currencies in
                self?.homeView.currencies = currencies
                self?.homeView.currencyCollection.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$totalMoney
            .sink { [weak self] totalMoney in
                self?.homeView.userTotalMoneyLabel.text = "\(totalMoney)"
            }
            .store(in: &cancellables)

        viewModel.$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
                if let user = user {
                    self?.homeView.configure(user: user)
                }
            }
            .store(in: &cancellables)
    }
}
