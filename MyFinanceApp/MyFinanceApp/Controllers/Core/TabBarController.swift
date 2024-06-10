import UIKit
import SwiftUI

enum Tabs: Int {
    case myMoney
    case budget
    case lenta
    case courses
    case profile
}

final class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        UserDataManager.shared.setupCurrentUser()
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {

        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white

        let homeController = HomeViewController(
            viewModel: HomeViewModel(
                bankCardRepository: BankCardRepositoryImpl(localService: LocalBankCardService(),
                                                           remoteService: RemoteBankCardService()),
                usersData: UserDataManager.shared))
        homeController.navigationItem.largeTitleDisplayMode = .always

        let myBudgetViewModel = MyBudgetViewModel(
            repository: BankCardRepositoryImpl(
                localService: LocalBankCardService(),
                remoteService: RemoteBankCardService()))
        let budgetController = UIHostingController(rootView: MyBudgetView(model: myBudgetViewModel))
        let profileViewModel = ProfileViewModel(usersData: UserDataManager.shared)
        let profileController = ProfileViewController(viewModel: profileViewModel)

        let homeNavigation = NavBarController(rootViewController: homeController)
        homeNavigation.navigationBar.prefersLargeTitles = true
        homeNavigation.setupNavBarColor()
        let budgetNavigation = NavBarController(rootViewController: budgetController)
        let profileNavigation = NavBarController(rootViewController: profileController)

        homeNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.myMoney,
            image: Resources.Images.TabBar.home,
            tag: Tabs.myMoney.rawValue)
        budgetNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.budget,
            image: Resources.Images.TabBar.budget,
            tag: Tabs.budget.rawValue)
        profileNavigation.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.profile,
            image: Resources.Images.TabBar.profile,
            tag: Tabs.profile.rawValue)

        setViewControllers([
            homeNavigation,
            budgetNavigation,
            profileNavigation
        ], animated: false)
    }
}
