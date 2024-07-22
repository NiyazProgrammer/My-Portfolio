import UIKit

class EnterView: UIView {
    var actionSwitchingRegistrationView: (() -> Void)?
    var actionSendData: ((String, String) -> Void)?
    var actionAlertPresent: ((UIAlertController) -> Void)?

    private lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "mainLogo")
        return logo
    }()
    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.textColor = .white

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var textFieldLogin: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите логин"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftViewMode = .always
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .next
        return textField
    }()
    private lazy var labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    private lazy var buttonEnter: UIButton = { [weak self] in
        var action = UIAction { _ in
            guard let textLogin = self?.textFieldLogin.text else {return}
            guard let textPassword = self?.textFieldPassword.text else {return}
            self?.actionSendData?(textLogin, textPassword)
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.backgroundColor = .systemGray4
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var viewRegistration: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var buttonRegistration: UIButton = {
        let action = UIAction { [weak self] _ in
            (self?.actionSwitchingRegistrationView ?? {})()
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.setTitle("Создать аккаунт", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var logoCompanyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconCompany")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var logoCompany: UILabel = {
        let label = UILabel()
        label.text = "Nets"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(logoImage)
        addSubview(buttonEnter)
        addSubview(viewRegistration)
        addSubview(buttonRegistration)
        addSubview(logoCompany)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        let mainStacklView1 = createVerticalStackView([labelLogin, textFieldLogin])
        let mainStacklView2 = createVerticalStackView([labelPassword, textFieldPassword])

        let iconAndLabelCompanyView = UIStackView(arrangedSubviews: [logoCompanyImage, logoCompany])
        iconAndLabelCompanyView.translatesAutoresizingMaskIntoConstraints = false
        iconAndLabelCompanyView.axis = .horizontal
        iconAndLabelCompanyView.spacing = 10

        addSubview(mainStacklView1)
        addSubview(mainStacklView2)
        addSubview(iconAndLabelCompanyView)
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -250),
            logoImage.widthAnchor.constraint(equalToConstant: 400),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainStacklView1.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10),
            mainStacklView1.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainStacklView1.heightAnchor.constraint(equalToConstant: 80),
            mainStacklView1.widthAnchor.constraint(equalToConstant: 280),
            mainStacklView2.topAnchor.constraint(equalTo:
                mainStacklView1.bottomAnchor),
            mainStacklView2.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainStacklView2.heightAnchor.constraint(equalToConstant: 80),
            mainStacklView2.widthAnchor.constraint(equalToConstant: 280),
            buttonEnter.topAnchor.constraint(equalTo: mainStacklView2.bottomAnchor, constant: 50),
            buttonEnter.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonEnter.heightAnchor.constraint(equalToConstant: 38),
            buttonEnter.widthAnchor.constraint(equalToConstant: 220),
            viewRegistration.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewRegistration.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewRegistration.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewRegistration.heightAnchor.constraint(equalToConstant: 120),
            buttonRegistration.centerXAnchor.constraint(equalTo: viewRegistration.centerXAnchor),
            buttonRegistration.topAnchor.constraint(equalTo: viewRegistration.topAnchor, constant: 15),
            buttonRegistration.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30 ),
            buttonRegistration.heightAnchor.constraint(equalToConstant: 38 ),
            iconAndLabelCompanyView.topAnchor.constraint(equalTo: buttonRegistration.bottomAnchor, constant: 20),
            iconAndLabelCompanyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconAndLabelCompanyView.heightAnchor.constraint(equalToConstant: 20),
            iconAndLabelCompanyView.widthAnchor.constraint(equalToConstant: 100),
            logoCompanyImage.widthAnchor.constraint(equalToConstant: 30),
            logoCompanyImage.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.actionAlertPresent?(alertController)
    }
}

extension EnterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldLogin:
            textFieldPassword.becomeFirstResponder()
        case textFieldPassword:
            textField.resignFirstResponder()
        default: break
        }
        return true
    }
}
