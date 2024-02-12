import UIKit

class RegistrationNickNameViewController: UIViewController, BroadcastFullNameForRegistration {
    var tupleTransfer: (String, String)?
    private let registrationNickNameView = RegistrationNickNameView(frame: .zero)
    override func loadView() {
        super.loadView()
        registrationNickNameView.actionAlertPresent = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        registrationNickNameView.actionCheckedForUniqueName = { nickName in
            return UserCoreDataManager.shared.checkUserInCoreData(nickName: nickName)
        }
        registrationNickNameView.actionSwitchingOnAccount = { [weak self] nickName in
            Task {
                var user = User(context: SystemCoreDataMethods.shared.viewContext)
                user.fullName = self?.tupleTransfer?.0
                user.password = self?.tupleTransfer?.1
                user.nickName = nickName
                user.numberSubscribers = 0
                user.numberPublication = 0
                user.numberSubscriptions = 0
                user.imageAvatarData = UIImage(named: "defaultImageAvatar")?.pngData()
                UserCoreDataManager.shared.saveNewRegistrationUser(user: user)

            await UserCoreDataManager.shared.tryLogin(nickName: user.nickName ?? "", password: user.password ?? "")
            EnterViewController().showTabBarController()
            }
        }
        view = registrationNickNameView
    }
}
