import UIKit

class ChangeDataUserCardView: UIView {
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private let nameCard: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
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
        return textField
    }()

    private let editImage: UIImageView = {
        let image = UIImageView(image: Resources.Images.ChangeDataCards.editPencil)
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor(hexString: "#bd8fda")
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()

    private lazy var nameAndTextField: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameCard, dataTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    init(cardName: String, textPlaceholder: String) {
        nameCard.text = cardName
        super.init(frame: .zero)
        dataTextField.placeholder = textPlaceholder
        addSubview(cardView)
        addSubview(editImage)
        cardView.addSubview(nameAndTextField)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 70),

            editImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            editImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            editImage.widthAnchor.constraint(equalToConstant: 25),
            editImage.heightAnchor.constraint(equalToConstant: 25),

            nameAndTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            nameAndTextField.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            nameAndTextField.trailingAnchor.constraint(equalTo: editImage.leadingAnchor, constant: -20)
        ])
    }
}
