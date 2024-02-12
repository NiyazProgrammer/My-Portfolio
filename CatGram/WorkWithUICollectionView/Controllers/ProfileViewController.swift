import UIKit

class ProfileViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers {
    lazy var profileView = ProfileView(frame: .zero)
    var optionViewController: UIViewController?
    var user: User? {
        didSet {
            navigationItem.title = user?.nickName
        }
    }
    override func loadView() {
        super.loadView()
        profileView.optionsTapped = { [weak self] in
            let vcSheet = OptionsSheetViewController()
            vcSheet.optionsSheetView.delegate = self
            let navVC = UINavigationController(rootViewController: vcSheet)
            if let sheet = navVC.sheetPresentationController {
                sheet.preferredCornerRadius = 30
                sheet.detents = [.custom(resolver: { context in
                    0.4 * context.maximumDetentValue
                }), .large()]
                sheet.largestUndimmedDetentIdentifier = .large
            }
            self?.navigationController?.present(navVC, animated: true)
            self?.optionViewController = vcSheet
        }

        profileView.subscribersTapped = { [weak self] in
            self?.navigationController?.pushViewController(SubscribersViewController(), animated: false)
        }

        profileView.subscribtionsTapped = { [weak self] in
            self?.navigationController?.pushViewController(SubscribtionsViewController(), animated: false)
        }
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        profileView.gridCollectionView.delegate = self
        UserCoreDataManager.shared.delegate1 = self
        updateData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    func setupNavigationBar() {
        let buttonForOptionsProfile = profileView.buttonForOptionsProfile
        let customBarButtonItem = UIBarButtonItem(customView: buttonForOptionsProfile)
        navigationItem.rightBarButtonItem = customBarButtonItem
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    func updateData() {
        Task {
            let cat = await UserCoreDataManager.shared.getCurrentUser()
            profileView.countPublication = cat?.publications?.count ?? 0
            profileView.countSubscribers = cat?.subscriptions?.count ?? 0
            profileView.countSubscriptions = cat?.subscribers?.count ?? 0
            profileView.cat = cat
            //profileView.updateNumberData()
            user = cat
            profileView.gridCollectionView.reloadData()
        }
    }
}
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let piblicationViewController = PublicationViewController()
        piblicationViewController.selectedIndexPath = indexPath
        piblicationViewController.delegate = self
        present(piblicationViewController, animated: true, completion: nil)
    }
}
extension ProfileViewController: AccessingRootController {
    func pushNewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
