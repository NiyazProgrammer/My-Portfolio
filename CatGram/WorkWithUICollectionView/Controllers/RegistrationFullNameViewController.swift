import UIKit
protocol BroadcastFullNameForRegistration {
    var tupleTransfer: (String, String)? { get set }
}
class RegistrationFullNameViewController: UIViewController {
    private let registrationView = RegistrationFullNameView(frame: .zero)
    var delegate: BroadcastFullNameForRegistration?
    override func loadView() {
        super.loadView()
        registrationView.actionSwitchingPasswordView = { [weak self] fullName in
            let registrationPasswordViewController = RegistrationPasswordViewController()
            self?.delegate = registrationPasswordViewController
            self?.delegate?.tupleTransfer = (fullName, "")
            self?.navigationController?.pushViewController(registrationPasswordViewController, animated: false)
        }
        view = registrationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//var activityIndicator: UIActivityIndicatorView!
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Создание и настройка индикатора активности
//    activityIndicator = UIActivityIndicatorView(style: .large)
//    activityIndicator.color = .gray
//    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(activityIndicator)
//
//    // Размещение индикатора активности по центру экрана
//    NSLayoutConstraint.activate([
//        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    ])
//}
//
//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    // Запуск анимации загрузки
//    activityIndicator.startAnimating()
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    // Остановка анимации загрузки
//    activityIndicator.stopAnimating()
//}
