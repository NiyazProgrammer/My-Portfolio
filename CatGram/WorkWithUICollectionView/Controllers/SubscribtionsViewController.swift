import UIKit
import CoreData

class SubscribtionsViewController: UIViewController {
    var fetchedResultController: NSFetchedResultsController<User>!
    
    let subscribtionsView = SubscribtionsView(frame: .zero)
    override func loadView() {
        super.loadView()
        subscribtionsView.actionDeleteSubscribe = { user in
            guard let currentUser = UserCoreDataManager.shared.user else { return }
            user.subscriptions?.remove(currentUser)
            currentUser.subscribers?.remove(user)
            SystemCoreDataMethods.shared.saveContext()
        }
        view = subscribtionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = SystemCoreDataMethods.shared.createAndSetFetchedResultController()
        fetchedResultController.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTable()
        updateSubscrptionsCurrentUser()
    }
    func updateTable() {
        subscribtionsView.tableSubscribers.reloadData()
    }
    func updateSubscrptionsCurrentUser() {
        let subscribtions = UserCoreDataManager.shared.obtainAuthorisationUser().subscribers
        subscribtionsView.setSubscribers(subscribers: Array(subscribtions ?? []))
    }
}
extension SubscribtionsViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .update, .insert, .delete:
            guard let indexPath = indexPath else { return }
            updateSubscrptionsCurrentUser()
            updateTable()
        default:
            break
        }
    }
 }
