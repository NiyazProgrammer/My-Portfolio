import UIKit
import Combine

class MainViewController: UIViewController {
    private let mainView: MainView

    private let mainViewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
        self.mainView = MainView(viewModel: mainViewModel, users: self.mainViewModel.users)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView

        mainView.didPressUsersCard = { [weak self] in
            self?.didPressUsersCard(user: self?.mainView.firstCardUser?.user ?? User())
        }

        mainView.likeTapped = { [weak self] in
            UIView.animate(withDuration: 0.5, animations: {
                self?.mainView.firstCardUser?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
                self?.mainView.firstCardUser?.center.x += (self?.mainView.bounds.width)! + 150
            }) { [weak self] _ in
                self?.mainViewModel.EnumbledUser(isLikeUser: true)
                self?.workWithViewsWhenEvaluated()
                self?.mainView.backButton.isEnabled = true
            }
        }

        mainView.dislikeTapped = { [weak self] in
            UIView.animate(withDuration: 0.5, animations: {
                self?.mainView.firstCardUser?.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 6))
                self?.mainView.firstCardUser?.center.x -= (self?.mainView.bounds.width)! + 150
            }) { [weak self] _ in
                self?.mainViewModel.EnumbledUser(isLikeUser: false)
                self?.workWithViewsWhenEvaluated()
                self?.mainView.backButton.isEnabled = true
            }
        }

        mainView.backTapped = { [weak self] in
            guard self?.mainView.backUsersCard != nil else { return }

            self?.workWithViewsDuringBackMoveCard()

            if self?.mainViewModel.likeTap ?? false {
                UIView.animate(withDuration: 0.5, animations: {
                    self?.mainView.firstCardUser?.transform = .identity
                    self?.mainView.firstCardUser?.center.x -= (self?.mainView.bounds.width ?? 0) + 150
               })
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self?.mainView.firstCardUser?.transform = .identity
                    self?.mainView.firstCardUser?.center.x += (self?.mainView.bounds.width ?? 0) + 150
               })
            }
            self?.mainViewModel.EnumbledUser(isLikeUser: false)
        }
    }

    private func workWithViewsWhenEvaluated() {
        mainViewModel.moveCard()
        mainView.backUsersCard = mainView.firstCardUser
        mainView.firstCardUser?.removeFromSuperview()
        mainView.firstCardUser = mainView.secondCardUser
        let card = CardUser(with: (mainViewModel.cards[1].user))
        mainView.secondCardUser = mainView.setupLayoutCard(userCard: card)
        mainView.sendSubviewToBack(mainView.secondCardUser ?? CardUser(with: User()))
    }

    private func workWithViewsDuringBackMoveCard() {
        mainView.backUsersCard =  mainView.setupLayoutCard(userCard: (mainView.backUsersCard)!)
        mainView.secondCardUser?.removeFromSuperview()
        mainView.secondCardUser =  mainView.firstCardUser
        mainView.firstCardUser =  mainView.backUsersCard
        mainView.backUsersCard = nil

        let car1 = mainView.firstCardUser ?? CardUser(with: User())
        let car2 = mainView.secondCardUser ?? CardUser(with: User())
        mainViewModel.backMoveCard(firstCardUser: car1, secondCardUser: car2)

        mainView.backButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupBindings()
    }

    func setupBindings() {
        mainViewModel.$likeTap.sink { [weak self]isEnumbled in
            self?.mainView.isEnumbledUser = isEnumbled
        }.store(in: &subscriptions)

        mainViewModel.$cards.sink { [weak self] cards in
            self?.mainView.cards = cards
        }.store(in: &subscriptions)
    }
    
    private var subscriptions = Set<AnyCancellable>()

    private func setupNavigationBar() {
        let logoImage = mainView.logoImage
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        titleView.addSubview(logoImage)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}

extension MainViewController {
    func didPressUsersCard(user: User) {
        let usersInfoVM = UsersInformationViewModel(user: user)
        let userInfoVC = UsersInformationViewController(viewModel: usersInfoVM)
        present(userInfoVC, animated: true, completion: nil)
    }
}
