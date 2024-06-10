import UIKit

class ChangePasswordView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    let dataCardsSV: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let saveButton: UIButton = {
        let button = SaveButtonBuilder()
            .setTitle("Изменить пароль")
            .setBackgroundColor(Resources.Colors.mainColorApp)
            .setCornerRadius(10)
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dataCardsSV)
        contentView.addSubview(saveButton)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            dataCardsSV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dataCardsSV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataCardsSV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            saveButton.topAnchor.constraint(equalTo: dataCardsSV.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
