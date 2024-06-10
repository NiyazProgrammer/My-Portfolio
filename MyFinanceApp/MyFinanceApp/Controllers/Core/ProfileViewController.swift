import UIKit
import Combine

class ProfileViewController: BaseViewController {

    private var profileView = ProfileView(frame: .zero)
    private let viewModel: ProfileViewModel
    private var currentUser: User?
    private var cancellable: Set<AnyCancellable> = []

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        title = Resources.Strings.TabBar.profile
        profileView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setUser()
        profileView.configure(user: currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: ""))
    }

    private func setupBindings() {
        viewModel.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            self?.profileView.configure(user: self?.currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: ""))
        }.store(in: &cancellable)
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didPressSettingCard() {
        let viewModel = SettingViewModel(usersData: UserDataManager.shared)
        navigationController?.pushViewController(SettingViewController(viewModel: viewModel), animated: true)
    }
}
