import UIKit

class AllUserTableViewCell: UITableViewCell {
    var actionSubscribe: (() -> Void)?
    var actionDelete: (() -> Void)?

    private lazy var imageAvatar: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var buttonAction: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        return button
    }()

    @objc func buttonPressedSubscriber() {
        (self.actionSubscribe ?? {})()
    }

    @objc func buttonPressedDelete() {
        (self.actionDelete ?? {})()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.addSubview(imageAvatar)
        contentView.addSubview(labelName)
        contentView.addSubview(buttonAction)
        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageAvatar.widthAnchor.constraint(equalToConstant: 30),
            imageAvatar.heightAnchor.constraint(equalToConstant: 30),
            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelName.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 5),
            buttonAction.widthAnchor.constraint(equalToConstant: 120),
            buttonAction.heightAnchor.constraint(equalToConstant: 20),
            buttonAction.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonAction.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
//            buttonSubscribe.trailingAnchor.constraint(equalTo: buttonDelete.leadingAnchor, constant: -20),
//            buttonSubscribe.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            buttonSubscribe.widthAnchor.constraint(equalToConstant: 100),
//            buttonSubscribe.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUser(with user: User) {
        labelName.text = user.nickName
        if let image = user.imageAvatarData {
            imageAvatar.image = UIImage(data: image)
        }
        trySubscriptions(with: user)
    }

    func trySubscriptions(with user: User) {
        let currentUser = UserCoreDataManager.shared.obtainAuthorisationUser().subscribers
        if ((currentUser?.contains(user)) ?? false) {
            buttonAction.setTitle("Вы подписаны", for: .normal)
            buttonAction.addTarget(self, action: #selector(buttonPressedDelete), for: .touchUpInside)

            buttonAction.backgroundColor = .gray
            buttonAction.setTitleColor(.black, for: .normal)
        } else if user.nickName == UserCoreDataManager.shared.user?.nickName {
            buttonAction.setTitle("Вы", for: .normal)
            buttonAction.backgroundColor = .clear
            buttonAction.setTitleColor(.white, for: .normal)
        } else {
            buttonAction.setTitle("Подписаться", for: .normal)
            buttonAction.addTarget(self, action: #selector(buttonPressedSubscriber), for: .touchUpInside)
            buttonAction.backgroundColor = .clear
            buttonAction.setTitleColor(.blue, for: .normal)
        }

    }
}
