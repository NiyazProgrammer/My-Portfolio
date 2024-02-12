import UIKit
class SubscribersTableViewCell: UITableViewCell {
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

    lazy var buttonDelete: UIButton = {
        let action = UIAction { [weak self] _ in
            (self?.actionDelete ?? {})()
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.setTitle("Удалить", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var buttonSubscribe: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Подписаться", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressedSubscriber), for: .touchUpInside)
        return button
    }()

    @objc func buttonPressedSubscriber() {
        (self.actionSubscribe ?? {})()
        buttonSubscribe.removeFromSuperview()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.addSubview(imageAvatar)
        contentView.addSubview(labelName)
        contentView.addSubview(buttonDelete)
        contentView.addSubview(buttonSubscribe)
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
            buttonDelete.widthAnchor.constraint(equalToConstant: 100),
            buttonDelete.heightAnchor.constraint(equalToConstant: 20),
            buttonDelete.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonDelete.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            buttonSubscribe.trailingAnchor.constraint(equalTo: buttonDelete.leadingAnchor, constant: -20),
            buttonSubscribe.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonSubscribe.widthAnchor.constraint(equalToConstant: 100),
            buttonSubscribe.heightAnchor.constraint(equalToConstant: 15)
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
            buttonSubscribe.removeFromSuperview()
        }
    }
}
