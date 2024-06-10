import Foundation

enum UserDefaultsKeys {
    static let status = "Status"
    static let userId = "UserId"
    static let userName = "UserName"
    static let userAvatarImageUrl = "UserAvatarImageUrl"
    static let email = "UserEmail"
    static let password = "Password"
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}

    func setStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: UserDefaultsKeys.status)
    }

    func getStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.status)
    }

    func setUserId(_ id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.userId)
    }

    func getUserId() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.userId) as? String ?? ""
    }

    func setUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: UserDefaultsKeys.userName)
    }

    func getUserName() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.userName) as? String ?? ""
    }

    func setUserEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: UserDefaultsKeys.email)
    }

    func getUserEmail() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.email) as? String ?? ""
    }

    func setUserPassword(_ password: String) {
        UserDefaults.standard.set(password, forKey: UserDefaultsKeys.password)
    }

    func getUserPassword() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.password) as? String ?? ""
    }

    func setUserAvatarImage(_ url: String) {
        UserDefaults.standard.set(url, forKey: UserDefaultsKeys.userAvatarImageUrl)
    }

    func getUserAvatarImage() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.userAvatarImageUrl) as? String ?? ""
    }
}
