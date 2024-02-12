import UIKit

class SettingAppView: UIView {
    var pushNewNC: (() -> Void)?
    lazy var tableSettingElement: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .black
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CellSetting")
        return table
    }()

    let settingElements: [String] = ["Аккаунт", "Тема", "Выйти"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableSettingElement)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableSettingElement.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableSettingElement.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableSettingElement.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tableSettingElement.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
extension SettingAppView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingElements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting", for: indexPath)
        cell.textLabel?.text = settingElements[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.tintColor = .darkGray
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch SettingElements(rawValue: indexPath.row) {
        case .account: break
        case .theme:
            self.pushNewNC?()
        case .exit:
            UserDefaults.standard.setValue(false, forKey: "loggedIn")
            UserCoreDataManager.shared.userDefaults?.removeObject(forKey: "CurrentUserNickName")
            UserCoreDataManager.shared.user = nil
            PublicationsCoreDataManager.shared.isCallObserver = true
            SceneDelegate.window?.rootViewController = UINavigationController(rootViewController: EnterViewController())
            SceneDelegate.window?.makeKeyAndVisible()
        case .none:
            print("Error: Unknown SettingElement for raw value \(indexPath.row)")
        }
    }
}
