import UIKit

class ChangePasswordViewController: BaseViewController {
    private let changePasswordView = ChangePasswordView(frame: .zero)
    private var changePasswordViewModel: ChangePasswordViewModel?

    init(changePasswordViewModel: ChangePasswordViewModel? = nil) {
        self.changePasswordViewModel = changePasswordViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = changePasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Изменить пароль"
        createChangeDataCards()
    }

    private func createChangeDataCards() {
        let dataManager = SystemUICardsManager()
        for card in dataManager.changePasswordUsersCards {
            card.dataTextField.delegate = self
            changePasswordView.dataCardsSV.addArrangedSubview(card)
        }
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
