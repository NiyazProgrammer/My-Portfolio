import UIKit
import Combine

class EditScreenViewController: BaseViewController {
    private let editView = EditUserInfoView(frame: .zero)
    private var viewModel: EditScreenViewModel
    private var currentUser: User?
    private var cancellable: Set<AnyCancellable> = []

    let imagePicker = ImagePicker()

    init(viewModel: EditScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = editView
        editView.didTapEditAvatarImage = { [weak self] in
            self?.imagePicker.showImagePicker(in: self ?? UIViewController())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Обо мне"
        createTextFieldUserDataCards()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setCurrentUser()
        editView.configure(user: currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: ""))
    }

    private func createTextFieldUserDataCards() {
        let dataManager = SystemUICardsManager()
        for card in dataManager.changeDataUsersCards {
            card.dataTextField.delegate = self
            editView.dataCardsSV.addArrangedSubview(card)
        }
    }

    private func setupBindings() {
        viewModel.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            self?.editView.configure(user: self?.currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: ""))
        }.store(in: &cancellable)
    }
}

extension EditScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for card in editView.dataCardsSV.arrangedSubviews {
            (card as? ChangeDataUserCardView)?.dataTextField.resignFirstResponder()
        }
        return true
    }
}
