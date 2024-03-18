import UIKit

class UsersInformationViewController: UIViewController {
    private let usersInformationView = UsersInformationView(frame: .zero)
    private let mainViewModel: UsersInformationViewModel

    init(viewModel: UsersInformationViewModel) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = usersInformationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        usersInformationView.user = mainViewModel.user
    }
}
