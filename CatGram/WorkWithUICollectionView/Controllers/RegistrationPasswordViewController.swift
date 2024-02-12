import UIKit

class RegistrationPasswordViewController: UIViewController, BroadcastFullNameForRegistration {
    var tupleTransfer: (String, String)?
    var delegate: BroadcastFullNameForRegistration?
    private let registrationPaasswordView = RegistrationPasswordView(frame: .zero)
    override func loadView() {
        super.loadView()
        registrationPaasswordView.actionSwitchingNickNameView = { [weak self] password in
            let registrationNickNameViewController = RegistrationNickNameViewController()
            self?.delegate = registrationNickNameViewController
            let fullName = self?.tupleTransfer?.0 ?? ""
            self?.delegate?.tupleTransfer = (fullName, password)
            self?.navigationController?.pushViewController(registrationNickNameViewController, animated: false)
        }
        view = registrationPaasswordView
    }
    override func viewDidLoad() {
        super.viewDidLoad()


    }
}
