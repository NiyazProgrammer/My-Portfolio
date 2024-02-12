import UIKit
import CoreData

protocol UpdateUserFriendsInfo: AnyObject {
    func updateFriendInfo()
}

class SubscribersViewController: UIViewController {
    var fetchedResultController: NSFetchedResultsController<User>!

    let subscribersView = SubscribersView(frame: .zero)
    override func loadView() {
        super.loadView()
        subscribersView.actionSubscribe = { user in
            guard let currentUser = UserCoreDataManager.shared.user else { return }
            currentUser.subscribers?.insert(user)
            user.subscriptions?.insert(currentUser)
            SystemCoreDataMethods.shared.saveContext()
        }
        subscribersView.actionDelete = { user in
            guard let currentUser = UserCoreDataManager.shared.user else { return }
            user.subscribers?.remove(currentUser)
            currentUser.subscriptions?.remove(user)
            SystemCoreDataMethods.shared.saveContext()
            let subscribers = UserCoreDataManager.shared.obtainAuthorisationUser().subscriptions
        }
        view = subscribersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = SystemCoreDataMethods.shared.createAndSetFetchedResultController()
        fetchedResultController.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateSubscrptionsCurrentUser()
    }
    func updateTableWithCachedData() {
        subscribersView.tableSubscribers.reloadData()
    }
    func updateSubscrptionsCurrentUser() {
        let subscribers = UserCoreDataManager.shared.obtainAuthorisationUser().subscriptions
        subscribersView.setSubscribers(subscribers: Array(subscribers ?? []))
    }
}
extension SubscribersViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert, .delete :
            guard let indexPath = indexPath else { return }
            updateSubscrptionsCurrentUser()
            updateTableWithCachedData()
            //subscribersView.tableSubscribers.reloadRows(at: [indexPath], with: .automatic)

        default:
            break
        }
    }
}
