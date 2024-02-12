import UIKit
protocol UpdateDataDelegate: AnyObject {
    func updateData()
}

class PublicationViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers {
    lazy var publicationView = PublicationsView(frame: .zero)
    weak var delegate: UpdateDataDelegate?
    func updateData() {
        Task {
            let cat = await UserCoreDataManager.shared.getCurrentUser()
            publicationView.cat = cat
            guard let newPublication = cat?.publications else {return}
            publicationView.publications = Array(newPublication)
            publicationView.cat = cat
            publicationView.tablePublication.reloadData()
        }
    }

    var selectedIndexPath: IndexPath?

    override func loadView() {
        super.loadView()
        publicationView.actionAlertPresent = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        view = publicationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserCoreDataManager.shared.delegate2 = self
        updateData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = selectedIndexPath {
            publicationView.tablePublication.scrollToRow(at: indexPath, at: .top, animated: true)
            selectedIndexPath = nil
        }
    }
}
