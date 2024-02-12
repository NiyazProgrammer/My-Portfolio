import UIKit

class SubscribtionsView: UIView {
    var actionDeleteSubscribe: ((User) -> Void)?
    private var subscribtions: [User] = [] {
        didSet {
            titleLabel.text = "\(String(describing: subscribtions.count)) Подписки"
        }
    }

    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0 Подписки"
        return label
    }()

    lazy var tableSubscribers: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.backgroundColor = .clear
        table.register(SubscribtionsTableViewCell.self, forCellReuseIdentifier: "CellSubscription")
//        table.separatorStyle = .singleLine
//        table.separatorColor = .white
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(titleView)
        titleView.addSubview(titleLabel)
        addSubview(tableSubscribers)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setSubscribers(subscribers: [User]) {
        self.subscribtions = subscribers
    }
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),

            tableSubscribers.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            tableSubscribers.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableSubscribers.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableSubscribers.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
extension SubscribtionsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribtions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "CellSubscription", for: indexPath
        ) as? SubscribtionsTableViewCell {
            let user = subscribtions[indexPath.row]
            cell.configureUser(with: user)
            cell.actionDeleteSubscribe = {  [weak self] in
                (self?.actionDeleteSubscribe ?? {_ in})(user)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
