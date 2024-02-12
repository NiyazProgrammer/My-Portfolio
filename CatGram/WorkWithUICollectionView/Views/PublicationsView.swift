import UIKit
class PublicationsView: UIView {
    var actionAlertPresent: ((UIAlertController) -> Void)?
    weak var controller: PublicationViewController?
    var publications: [Publication] = []
    var cat: User?
    lazy var tablePublication: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(PublicationTableViewCell.self, forCellReuseIdentifier: "Publisher")
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(tablePublication)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tablePublication.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tablePublication.leadingAnchor.constraint(equalTo: leadingAnchor),
            tablePublication.trailingAnchor.constraint(equalTo: trailingAnchor),
            tablePublication.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
extension PublicationsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tablePublication.dequeueReusableCell(
            withIdentifier: "Publisher", for: indexPath
        ) as? PublicationTableViewCell {

            let sortedPosts = publications.sorted { (post1, post2) -> Bool in
                return post1.date ?? Date() > post2.date ?? Date()
            }
            let publication = sortedPosts[indexPath.row]
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
extension PublicationsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 770
    }
}
extension PublicationsView: PublicationCellLikeDelegate {
    func toggleLike(publicationId: UUID) {
        PublicationsCoreDataManager.shared.toggleLike(publicationId: publicationId, userName: cat?.nickName ?? "")
    }
    func didTapLikeButton() {
        tablePublication.reloadData()
    }
}
