import UIKit

class EditUserInfoView: UIView {
    var didTapEditAvatarImage: (() -> Void)?

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

    lazy var avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        return avatar
    }()

    private lazy var editAvatarImageBtn: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.didTapEditAvatarImage?()
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle("Выбрать фотографию", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let dataCardsSV: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let saveButton: UIButton = {
        let button = SaveButtonBuilder()
            .setTitle("Сохранить")
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
        contentView.addSubview(avatarImage)
        contentView.addSubview(editAvatarImageBtn)
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

            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            avatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),

            editAvatarImageBtn.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            editAvatarImageBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            dataCardsSV.topAnchor.constraint(equalTo: editAvatarImageBtn.bottomAnchor, constant: 10),
            dataCardsSV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataCardsSV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            saveButton.topAnchor.constraint(equalTo: dataCardsSV.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configure(user: User) {
        if let avatarImageUrl = user.avatarImageUrl, let url = URL(string: avatarImageUrl) {
            avatarImage.kf.setImage(with: url)
        } else {
            avatarImage.image = UIImage(named: "defaultAvatar")
        }

        for card in dataCardsSV.arrangedSubviews {
            print(card)
        }
    }
}
