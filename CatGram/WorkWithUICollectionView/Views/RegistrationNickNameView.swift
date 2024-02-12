import UIKit

class RegistrationNickNameView: UIView {
    var actionCheckedForUniqueName: ((String) -> Bool)?
    var actionSwitchingOnAccount: ((String) -> Void)?
    var actionAlertPresent: ((UIAlertController) -> Void)?
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте имя пользователя"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nickNameTextField: UITextField = {
        let nickNameTextField = UITextField()
        nickNameTextField.placeholder = "Имя пользователя"
        nickNameTextField.borderStyle = .roundedRect
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nickNameTextField
    }()

    private lazy var nextButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let nickName = self?.nickNameTextField.text ?? ""
            if !(self?.actionCheckedForUniqueName ?? { _ in false})(nickName) {
                (self?.actionSwitchingOnAccount ?? { _ in })(nickName)
            } else {
                self?.viewAlert()
            }
        }
        let nextButton = UIButton(type: .system, primaryAction: action)
        nextButton.setTitle("Зарегистрировать", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .blue
        nextButton.layer.cornerRadius = 15
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        return nextButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(nickNameTextField)
        addSubview(nextButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewAlert() {
        let alertController = UIAlertController(title: "Введены не ккоректные данные", message: "Это имя уже используется, пожалуйста придумайте другое Имя", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.actionAlertPresent?(alertController)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nickNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            nickNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nickNameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 55),
            nextButton.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
