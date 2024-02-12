import UIKit

class RegistrationFullNameView: UIView {
    var actionSwitchingPasswordView: ((String) -> Void)?
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Как вас зовут?"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Введите ваше имя"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()

    private lazy var nextButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let fullName = self?.nameTextField.text ?? ""
            (self?.actionSwitchingPasswordView ?? { _ in })(fullName)
        }
        let nextButton = UIButton(type: .system, primaryAction: action)
        nextButton.setTitle("Далее", for: .normal)
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
        addSubview(nameTextField)
        addSubview(nextButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            nameTextField.heightAnchor.constraint(equalToConstant: 55),
            nextButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
