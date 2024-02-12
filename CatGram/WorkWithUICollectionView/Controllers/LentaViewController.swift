import UIKit
class LentaViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers {
    lazy var storyView = LentaView(frame: .zero)
    override func loadView() {
        super.loadView()
        storyView.actionAlertPresent = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        view = storyView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storyView.tableStoryPosts.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        UserCoreDataManager.shared.delegate = self
        updateData()
    }
    func setupNavigationBar() {
        navigationItem.title = "Catgram"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    func updateData() {
        Task {
            let cat = await UserCoreDataManager.shared.getCurrentUser()
            let publications = await PublicationsCoreDataManager.shared.asyncGetEverythingPublication()
            storyView.publication = publications
            storyView.cat = cat
            storyView.tableStoryPosts.reloadData()
        }
    }
}
