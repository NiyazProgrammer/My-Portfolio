import UIKit

class MainView: UIView {
    var isEnumbledUser: Bool?
    var cards: [CardUser] = []
    var backUsersCard: CardUser?
    var firstCardUser: CardUser?
    var secondCardUser: CardUser?
    var likeTapped: (() -> Void)?
    var dislikeTapped: (() -> Void)?
    var backTapped: (() -> Void)?
    var didPressUsersCard: (() -> Void)?

    let logoImage: UIImageView = {
        let logo = UIImageView(image: Resources.Images.baseView.logoApp )
        logo.contentMode = .scaleAspectFit
        logo.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return logo
    }()

    let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Resources.Images.ActionButton.like, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.clear, for: .normal)
        return button
    }()

    lazy var dislikeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Resources.Images.ActionButton.disLike, for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Resources.Images.ActionButton.back, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var actionButtonSV = {
        let stack = UIStackView(arrangedSubviews: [backButton, dislikeButton, likeButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    var viewModel: MainViewModel

    init(viewModel: MainViewModel, users: [User]) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white

        secondCardUser = self.setupLayoutCard(userCard: CardUser(with: users[1]))
        firstCardUser = self.setupLayoutCard(userCard: CardUser(with: users[0]))

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)

        setupLayoutActionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayoutActionButton() {
        addSubview(actionButtonSV)

        NSLayoutConstraint.activate([
            actionButtonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionButtonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButtonSV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        (didPressUsersCard ?? { })()
    }

    @objc func likeButtonTapped() {
        (likeTapped ?? { })()
    }

    @objc func dislikeButtonTapped() {
        (dislikeTapped ?? { })()
    }

    @objc func backButtonTapped() {
        (backTapped ?? { })()
    }

    func setupLayoutCard(userCard: CardUser) -> CardUser {
        addSubview(userCard)
        userCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userCard.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            userCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userCard.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        userCard.addGestureRecognizer(tapGesture)
        return userCard
    }
}
