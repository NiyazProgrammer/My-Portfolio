import UIKit

class TabBarController {
    static var shared = TabBarController()
    private init() {

    }
    func showTabBarController() {
        let firstViewController = MainPageMarketViewController()
        firstViewController.view.backgroundColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.4)
        firstViewController.tabBarItem = UITabBarItem(
            title: "Рынки",
            image: UIImage(named: "market"),
            selectedImage: UIImage(named: "market")
        )
        let secondViewController = PortfolioViewController()
        secondViewController.view.backgroundColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.4)
        secondViewController.tabBarItem = UITabBarItem(
            title: "Портфель",
            image: UIImage(named: "portfolio"),
            selectedImage: UIImage(named: "portfolio")
        )

        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)

        let tabBarController = UITabBarController()
        firstNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 233, green: 237, blue: 243, alpha: 1.0)
        ]
        secondNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 233, green: 237, blue: 243, alpha: 1.0)
        ]
        tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: false)

        tabBarController.tabBar.barTintColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.6)
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.6)
        tabBarController.tabBar.backgroundColor = UIColor(red: 0.32, green: 0.38, blue: 0.48, alpha: 0.4)
        SceneDelegate.window?.rootViewController = tabBarController
        SceneDelegate.window?.makeKeyAndVisible()
    }
}
