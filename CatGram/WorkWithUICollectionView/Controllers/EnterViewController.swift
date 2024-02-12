import UIKit

class EnterViewController: UIViewController {
    lazy var enterView = EnterView(frame: .zero)
    override func loadView() {
        super.loadView()
        enterView.actionSendData = { [weak self] nickName, password in
            Task {
                await UserCoreDataManager.shared.tryLogin(nickName: nickName, password: password)
                if await UserCoreDataManager.shared.getCurrentUser() != nil {
                    UserDefaults.standard.setValue(true, forKey: "loggedIn")
                    UserCoreDataManager.shared.saveAuthorisationUser()
                    self?.showTabBarController()
                } else if nickName == "" || password == "" {
                    self?.enterView.showAlert(title: "Внимание", message: "Заполните все поля")
                } else {
                    self?.enterView.showAlert(title: "Внимание", message: "Введены некорректные данные")
                }
            }
        }
        enterView.actionAlertPresent = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        enterView.actionSwitchingRegistrationView = { [weak self] in
            self?.navigationController?.pushViewController(RegistrationFullNameViewController(), animated: false)
        }
        view = enterView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    func showTabBarController() {
        let firstViewController = ProfileViewController()
        firstViewController.view.backgroundColor = .white
        firstViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "profile"),
            selectedImage: UIImage(named: "profile")
        )
        let secondViewController = LentaViewController()
        secondViewController.view.backgroundColor = .white
        secondViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "home"),
            selectedImage: UIImage(named: "home")
        )
        let thirdViewController = AllUserViewController()
        thirdViewController.view.backgroundColor = .white
        thirdViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "users"),
            selectedImage: UIImage(named: "users")
        )

        firstViewController.view.backgroundColor = .black
        secondViewController.view.backgroundColor = .black
        thirdViewController.view.backgroundColor = .black

        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)

        let tabBarController = UITabBarController()
        firstNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        secondNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        thirdNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        tabBarController.setViewControllers([firstNavigationController,thirdViewController, secondNavigationController], animated: false)

        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.tabBar.backgroundColor = .darkGray
        SceneDelegate.window?.rootViewController = tabBarController
        SceneDelegate.window?.makeKeyAndVisible()
    }
    func setupNavigationBar() {
        navigationItem.title = "Welcome to CatGram"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
