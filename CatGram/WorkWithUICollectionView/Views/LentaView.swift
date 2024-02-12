import UIKit
class LentaView: UIView {
    var actionAlertPresent: ((UIAlertController) -> Void)?
    var publication: [Publication] = []
    var cat: User?
    lazy var storyImagesColeectionView: UICollectionView = {
        var size = ((UIScreen.main.bounds.size.width) / 4) - 10
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: size, height: size)
        print(((UIScreen.main.bounds.size.width) / 4) - 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.register(
            StoryCollectionViewCell.self,
            forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var tableStoryPosts: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(LentaPostsTableViewCell.self, forCellReuseIdentifier: "LentaPosts")
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(storyImagesColeectionView)
        addSubview(tableStoryPosts)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            storyImagesColeectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            storyImagesColeectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyImagesColeectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyImagesColeectionView.heightAnchor.constraint(equalToConstant: 100),
            tableStoryPosts.topAnchor.constraint(equalTo: storyImagesColeectionView.bottomAnchor, constant: 10),
            tableStoryPosts.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableStoryPosts.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableStoryPosts.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
extension LentaView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? StoryCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
extension LentaView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publication.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableStoryPosts.dequeueReusableCell(
            withIdentifier: "LentaPosts", for: indexPath
        ) as? LentaPostsTableViewCell {
            let publication = publication[indexPath.row]
            cell.isLiked = PublicationsCoreDataManager.shared.tryLiked(publicationId: publication.id ?? UUID(), userName: cat?.nickName ?? "")
            cell.configure(with: publication)
            cell.actionAlertPresent = { [weak self] alert in
                self?.actionAlertPresent?(alert)
            }
            cell.delegateLike = self
            cell.indexPath = indexPath
            cell.currentPublication = publication
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension LentaView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 770
    }
}
extension LentaView: PublicationCellLikeDelegate {
    func toggleLike(publicationId: UUID) {
        PublicationsCoreDataManager.shared.toggleLike(publicationId: publicationId, userName: cat?.nickName ?? "")
    }
    func didTapLikeButton() {
        tableStoryPosts.reloadData()
    }
}
