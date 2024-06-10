import UIKit
import Combine

class SettingViewController: BaseViewController {
    private let settingView = SettingView(frame: .zero)
    private let viewModel: SettingViewModel
    private var cancellable: Set<AnyCancellable> = []

    private var currentUser: User?

    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = settingView

        settingView.exitAccount = { [weak self] in
            Task {
                await self?.viewModel.exitAccount()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        setupBindings()
        settingView.editButtondelegate = self
        settingView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setCurrentUser()
        if let user = currentUser {
            settingView.configure(user: user)
        }
    }

    private func setupBindings() {
        viewModel.$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
                if let user = user {
                    self?.settingView.configure(user: user)
                }
            }
            .store(in: &cancellable)
    }
}

extension SettingViewController: SettingViewDelegate {
    func didPressChangePasswordCard() {
        let changePasswordVM = ChangePasswordViewModel()
        let changePasswordVC = ChangePasswordViewController(changePasswordViewModel: changePasswordVM)
        navigationController?.pushViewController(changePasswordVC, animated: true)
    }
}

extension SettingViewController: SettingViewForButtonDelegate {
    func didPressButtonEdit() {
        let viewModel = EditScreenViewModel(usersData: UserDataManager.shared)
        let editController = EditScreenViewController(viewModel: viewModel)
        navigationController?.pushViewController(editController, animated: true)
    }
}
