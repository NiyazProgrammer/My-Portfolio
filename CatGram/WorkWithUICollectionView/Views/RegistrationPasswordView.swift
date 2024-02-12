//
//  RegistrationSecondView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 13.12.2023.
//

import UIKit

class RegistrationPasswordView: UIView {
    var actionSwitchingNickNameView: ((String) -> Void)?
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создайте пароль"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    private lazy var nextButton: UIButton = {
        let action = UIAction { [weak self] _ in
            let password = self?.passwordTextField.text ?? ""
            (self?.actionSwitchingNickNameView ?? { _ in })(password)
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
        addSubview(passwordTextField)
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
            passwordTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            nextButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
