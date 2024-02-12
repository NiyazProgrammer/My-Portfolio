import UIKit

class ThemesView: UIView {

    lazy var tableThemes: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .black
        table.register(UITableViewCell.self, forCellReuseIdentifier: "CellSetting")
        return table
    }()

    private var themes: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableThemes)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setThemesApp(themes: [String]) {
        self.themes = themes
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableThemes.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableThemes.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableThemes.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tableThemes.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
extension ThemesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSetting", for: indexPath)
        cell.textLabel?.text = themes[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.tintColor = .darkGray
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            // реализация темной темы
            break
        default:
            // реализация светлой темы
            break
        }
    }
}
