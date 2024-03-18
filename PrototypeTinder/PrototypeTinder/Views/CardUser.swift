import UIKit

class CardUser: UIView {
    private lazy var imageUser: UIImageView = {
        let card = UIImageView(image: UIImage(data: user.photo!))
        card.contentMode = .scaleAspectFill
        card.isUserInteractionEnabled = true
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 20
        card.clipsToBounds = true
        return card
    }()

    private lazy var nameAndAgeUser: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = (user.name ?? "No name") +
            "" + (user.lastname ?? "") +
            " " + String(describing: user.age)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private lazy var usersWork: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user.job
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private lazy var usersPlaceStudy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user.university
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let usersWorkLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "workLogo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        return logo
    }()

    private let usersPlaceStudyLogo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "studyLogo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        return logo
    }()

    var user: User
    private var mainUsersInfo: UIStackView?
    
    init(with user: User) {
        self.user = user
        super.init(frame: .zero)
        addSubview(imageUser)

        NSLayoutConstraint.activate([
            imageUser.topAnchor.constraint(equalTo: topAnchor),
            imageUser.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageUser.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageUser.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        createMainUsersInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createChildDescription(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }

    private func createMainDescription() -> UIStackView {
        let worklStackView = createChildDescription(views: [usersWorkLogo, usersPlaceStudyLogo])
        let studyStackView = createChildDescription(views: [usersWork, usersPlaceStudy])


        let mainStackView = UIStackView(arrangedSubviews: [worklStackView, studyStackView])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 5
        return mainStackView
    }

    private func createMainUsersInfo() {
        let mainDescriptionStackView = createMainDescription()

        mainUsersInfo = UIStackView(arrangedSubviews: [nameAndAgeUser, mainDescriptionStackView])
        if let mainUsersInfo = self.mainUsersInfo {
            mainUsersInfo.translatesAutoresizingMaskIntoConstraints = false
            mainUsersInfo.axis = .vertical
            mainUsersInfo.distribution = .fillEqually
            mainUsersInfo.spacing = 15
            imageUser.addSubview(mainUsersInfo)

            NSLayoutConstraint.activate([
                mainUsersInfo.leadingAnchor.constraint(equalTo: imageUser.leadingAnchor, constant: 10),
                mainUsersInfo.trailingAnchor.constraint(equalTo: imageUser.trailingAnchor, constant: -10),
                mainUsersInfo.bottomAnchor.constraint(equalTo: imageUser.bottomAnchor, constant: -20),
                mainUsersInfo.heightAnchor.constraint(equalToConstant: 100),
            ])
        }
    }
}
