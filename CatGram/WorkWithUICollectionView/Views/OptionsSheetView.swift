import UIKit

protocol AccessingRootController: AnyObject {
    func pushNewController(_ viewController: UIViewController)
}
class OptionsSheetView: UIView {
    var dismisNC: (() -> Void)?
    var getDataElementOptions: (() -> [OptionElement])?
    private var optionsElements: [OptionElement] = []
    weak var delegate: AccessingRootController?
    lazy var tableTab: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .black
        table.register(OptionsSheetTableViewCell.self, forCellReuseIdentifier: "OptionCell")
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(tableTab)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setDataElementOptions(optionElement: [OptionElement]) {
        optionsElements = optionElement
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableTab.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableTab.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableTab.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tableTab.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}

extension OptionsSheetView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsElements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "OptionCell", for: indexPath
        ) as? OptionsSheetTableViewCell {
            let optionsElement = optionsElements[indexPath.row]
            guard let imageElement = optionsElement.imageElement else { return UITableViewCell()}
            cell.configureCell(text: optionsElement.labelElement, image: imageElement)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let settingView = SettingAppViewController()
            self.dismisNC?()
            delegate?.pushNewController(settingView)
        case 1:
            // переход на страницу "Сохранено"
            break
        case 2:
            // переход на страницу "Близкие друзья"
            break
        case 3:
            // переход на страницу "Избранное"
            break
        default:
            Task {
                await PublicationsCoreDataManager.shared.createPost(user: UserCoreDataManager.shared.getCurrentUser() ?? User(context: SystemCoreDataMethods.shared.viewContext))
                self.dismisNC?()
            }
            
        }
    }
}
