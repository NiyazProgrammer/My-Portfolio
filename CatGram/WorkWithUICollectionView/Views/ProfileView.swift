import UIKit

class ProfileView: UIView {
    var subscribersTapped: (() -> Void)?
    var subscribtionsTapped: (() -> Void)?
    var optionsTapped: (() -> Void)?
    var isAddNewPost: Bool = false
    var previousPublications: Set<Publication>  = []
    var currentPublication: Set<Publication>  = [] {
        didSet {
            previousPublications = oldValue
        }
    }
    var cat: User? {
        didSet {
            avatarImage.image = UIImage(data: cat?.imageAvatarData ?? Data())
            descriptionCanal.text = cat?.descriptions
            currentPublication = cat?.publications ?? []
            isAddNewPost = true
        }
    }
    var countPublication: Int = 0 {
        didSet {
            numberPublication.text = "\(countPublication)"
        }
    }
    var countSubscribers: Int = 0 {
        didSet {
            numberSubscribers.text = "\(countSubscribers)"
        }
    }
    var countSubscriptions: Int = 0 {
        didSet {
            numberSubscriptions.text = "\(countSubscriptions)"
        }
    }
    lazy var buttonForOptionsProfile: UIButton = {
        var action = UIAction { [weak self] _ in
            (self?.optionsTapped ?? {})()
        }
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(named: "threePoints")
        button.setImage(buttonImage, for: .normal)
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(data: UserCoreDataManager.shared.user?.imageAvatarData ?? Data())
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var textPublication: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Публикации"
        return text
    }()
    lazy var numberPublication: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        return text
    }()
    lazy var textSubscribers: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Подписчики"
        return text
    }()
    lazy var numberSubscribers: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        return text
    }()
    lazy var textSubscriptions: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Подписки"
        return text
    }()
    lazy var numberSubscriptions: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        return text
    }()
    lazy var descriptionCanal: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .white
        return text
    }()
    lazy var gridCollectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width) / 3, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            GridCollectionViewCell.self,
            forCellWithReuseIdentifier: GridCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        addSubview(avatarImage)
        addSubview(descriptionCanal)
        addSubview(gridCollectionView)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let mainStackView1 = createVerticalStackView([textPublication, numberPublication])
        let mainStacklView2 = createVerticalStackView([textSubscribers, numberSubscribers])
        let mainStacklView3 = createVerticalStackView([textSubscriptions, numberSubscriptions])

        let tapGestureSubscribe = UITapGestureRecognizer(target: self, action: #selector(showSubscribers))
        mainStacklView2.addGestureRecognizer(tapGestureSubscribe)

        let tapGestureSubscriptions = UITapGestureRecognizer(target: self, action: #selector(showSubscribtions))
        mainStacklView3.addGestureRecognizer(tapGestureSubscriptions)

        addSubview(mainStackView1)
        addSubview(mainStacklView2)
        addSubview(mainStacklView3)
            NSLayoutConstraint.activate([
                avatarImage.widthAnchor.constraint(equalToConstant: 80),
                avatarImage.heightAnchor.constraint(equalToConstant: 80),
                avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                mainStackView1.trailingAnchor.constraint(equalTo: mainStacklView2.leadingAnchor, constant: -10),
                mainStackView1.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStackView1.widthAnchor.constraint(equalToConstant: 80),
                mainStackView1.heightAnchor.constraint(equalToConstant: 40),
                mainStacklView2.trailingAnchor.constraint(equalTo: mainStacklView3.leadingAnchor, constant: -10),
                mainStacklView2.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView2.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView2.heightAnchor.constraint(equalToConstant: 40),
                mainStacklView3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                mainStacklView3.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView3.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView3.heightAnchor.constraint(equalToConstant: 40),
                descriptionCanal.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
                descriptionCanal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                descriptionCanal.trailingAnchor.constraint(equalTo: trailingAnchor),
                gridCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                gridCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                gridCollectionView.topAnchor.constraint(equalTo: descriptionCanal.bottomAnchor, constant: 15),
                gridCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    @objc func showSubscribers() {
        (subscribersTapped ?? {})()
    }

    @objc func showSubscribtions() {
        (subscribtionsTapped ?? {})()
    }

    func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }
}
extension ProfileView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let newCat = cat else {return 0}
        return newCat.publications?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GridCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? GridCollectionViewCell {
            let allPublication = Array(currentPublication)
            let sortedPosts = allPublication.sorted { (post1, post2) -> Bool in
                return post1.date ?? Date() > post2.date ?? Date()
            }
            cell.configure(with: sortedPosts[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
//extension ProfileView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//           return 0
//       }
//}
