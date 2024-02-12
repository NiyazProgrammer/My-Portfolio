import UIKit
import CoreData

class AllUserViewController: UIViewController {
    
    var fetchedResultController: NSFetchedResultsController<User>!

    let allUsersView = AllUserView(frame: .zero)
    override func loadView() {
        super.loadView()
        allUsersView.actionSubscriber = { user in
            guard let currentUser = UserCoreDataManager.shared.user else { return }
            currentUser.subscribers?.insert(user)
            user.subscriptions?.insert(currentUser)
            SystemCoreDataMethods.shared.saveContext()
        }
        allUsersView.actionDeleteSubscribe = { user in
            guard let currentUser = UserCoreDataManager.shared.user else { return }
            user.subscriptions?.remove(currentUser)
            currentUser.subscribers?.remove(user)
            SystemCoreDataMethods.shared.saveContext()
        }
        view = allUsersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = SystemCoreDataMethods.shared.createAndSetFetchedResultController()
        fetchedResultController.delegate = self
        updateSubscrptionsCurrentUser()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTable()
        updateSubscrptionsCurrentUser()
    }
    func updateTable() {
        allUsersView.tableSubscribers.reloadData()
    }
    func updateSubscrptionsCurrentUser() {
        let subscribtions = UserCoreDataManager.shared.obtainAllUsers()
        allUsersView.setSubscribers(subscribers: Array(subscribtions))
    }
}
extension AllUserViewController: NSFetchedResultsControllerDelegate {
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
