import UIKit
import SnapKit

private enum NumberCard {
    static let setting = 0
    static let favorites = 1
    static let notification = 2
}

protocol ProfileViewDelegate: AnyObject {
    func didPressSettingCard()
}

class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?

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

    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 7.0
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.sizeToFit()
        return label
    }()

    private lazy var generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Главная"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let generalCardsSV: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(generalLabel)
        contentView.addSubview(generalCardsSV)

        createAllCards()
        setupContrait()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }

    private func createCard(numbersCard: Int, withTapHandler tapHandler: Selector) {
        let dataManager = SystemUICardsManager()
        let card = dataManager.generalCardsMainProfile[numbersCard]
        let tapGesture = UITapGestureRecognizer(target: self, action: tapHandler)
        card.addGestureRecognizer(tapGesture)
        generalCardsSV.addArrangedSubview(card)
    }

    private func createAllCards() {
        createCard(
            numbersCard: NumberCard.setting,
            withTapHandler: #selector(handleSettingCardTap(_:))
        )
    }

    @objc func handleSettingCardTap(_ sender: UITapGestureRecognizer) {
        delegate?.didPressSettingCard()
    }

    func configure(user: User) {
        nameLabel.text = user.userName
        if let avatarImageUrl = user.avatarImageUrl, let url = URL(string: avatarImageUrl) {
            profileImage.kf.setImage(with: url)
        } else {
            profileImage.image = UIImage(named: "defaultAvatar")
        }
    }

    func setupContrait() {
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

            profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),

            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            generalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            generalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            generalCardsSV.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 20),
            generalCardsSV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            generalCardsSV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            generalCardsSV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
