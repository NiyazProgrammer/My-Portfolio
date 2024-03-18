import UIKit

class UsersInformationView: UIView {
    var user: User? {
        didSet {
            avatarUser.image = UIImage(data: user?.photo ?? Data())
            let name = user?.name ?? " No name"
            let lastname = user?.lastname ?? ""
            let age = String(describing: user!.age)
            nameAndAgeUser.text = name + " " + lastname + ", " + age
            locationUser.text = user?.city
            usersWork.text = user?.job
            usersPlaceStudy.text = user?.university
            aboutMeDescription.text = user?.aboutMe
        }
    }

    private lazy var avatarUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .gray
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()

    private var nameAndAgeUser: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private var locationUser: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()

    private lazy var usersWork: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private lazy var usersPlaceStudy: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let usersWorkLogo: UIImageView = {
        let logo = UIImageView(image: Resources.Images.shortDescription.brownWorkLogo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        return logo
    }()

    private let usersPlaceStudyLogo: UIImageView = {
        let logo = UIImageView(image: Resources.Images.shortDescription.blackStudyLogo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        return logo
    }()

    lazy var descriptionUser: UIStackView = {
        let description = createMainDescription()
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Resources.Strings.aboutMe
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let aboutMeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let viewDescription: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    private let locationLogo: UIImageView = {
        let logo = UIImageView(image: Resources.Images.shortDescription.locationLogo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        return logo
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupLayout()
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
        return stackView
    }

    private func createMainDescription() -> UIStackView {
        let worklStackView = createChildDescription(views: [usersWorkLogo, usersPlaceStudyLogo])
        let studyStackView = createChildDescription(views: [usersWork, usersPlaceStudy])
        studyStackView.alignment = .leading

        let mainStackView = UIStackView(arrangedSubviews: [worklStackView, studyStackView])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 10
        return mainStackView
    }

    private lazy var locationSV: UIStackView = {
        let locationSV = UIStackView(arrangedSubviews: [locationLogo, locationUser])
        locationSV.axis = .horizontal
        locationSV.distribution = .fillProportionally
        locationSV.spacing = 5
        locationSV.translatesAutoresizingMaskIntoConstraints = false
        return locationSV
    }()

    private func setupLayout() {
        addSubview(avatarUser)
        addSubview(descriptionUser)
        addSubview(aboutMeLabel)
        addSubview(nameAndAgeUser)
        addSubview(locationSV)
        addSubview(viewDescription)
        viewDescription.addSubview(aboutMeDescription)

        NSLayoutConstraint.activate([
            avatarUser.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarUser.widthAnchor.constraint(equalToConstant: 80),
            avatarUser.heightAnchor.constraint(equalToConstant: 80),

            nameAndAgeUser.topAnchor.constraint(equalTo: avatarUser.topAnchor, constant: 10),
            nameAndAgeUser.leadingAnchor.constraint(equalTo: avatarUser.trailingAnchor, constant: 25),
            nameAndAgeUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            locationSV.topAnchor.constraint(equalTo: nameAndAgeUser.bottomAnchor, constant: 10),
            locationSV.leadingAnchor.constraint(equalTo: nameAndAgeUser.leadingAnchor),

            descriptionUser.topAnchor.constraint(equalTo: avatarUser.bottomAnchor, constant: 50),
            descriptionUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            aboutMeLabel.topAnchor.constraint(equalTo: descriptionUser.bottomAnchor, constant: 30),
            aboutMeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            aboutMeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            viewDescription.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 20),
            viewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            aboutMeDescription.topAnchor.constraint(equalTo: viewDescription.topAnchor, constant: 10),
            aboutMeDescription.leadingAnchor.constraint(equalTo: viewDescription.leadingAnchor, constant: 20),
            aboutMeDescription.trailingAnchor.constraint(equalTo: viewDescription.trailingAnchor, constant: -20),
            aboutMeDescription.bottomAnchor.constraint(equalTo: viewDescription.bottomAnchor, constant: -10)
        ])
    }
}
