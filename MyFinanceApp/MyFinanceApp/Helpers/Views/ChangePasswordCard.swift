import UIKit

class ChangePasswordCard: UIView {
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    lazy var dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 4
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.contentMode = .topLeft
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var hiddenButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "eye.fill")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor(hexString: "#bd8fda")
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapHiddenButton), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    init(textPlaceholder: String) {
        super.init(frame: .zero)
        dataTextField.placeholder = textPlaceholder
        addSubview(cardView)
        cardView.addSubview(hiddenButton)
        cardView.addSubview(dataTextField)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 60),

            hiddenButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            hiddenButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            hiddenButton.widthAnchor.constraint(equalToConstant: 35),
            hiddenButton.heightAnchor.constraint(equalToConstant: 35),

            dataTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            dataTextField.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            dataTextField.trailingAnchor.constraint(equalTo: hiddenButton.leadingAnchor, constant: -20)
        ])
    }

    @objc private func tapHiddenButton() {
        if dataTextField.isSecureTextEntry {
            dataTextField.isSecureTextEntry = false
            hiddenButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            dataTextField.isSecureTextEntry = true
            hiddenButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
}
