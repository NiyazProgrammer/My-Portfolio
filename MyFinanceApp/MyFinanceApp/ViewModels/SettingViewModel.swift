import UIKit
import SwiftUI

class SettingViewModel {
    @Published var currentUser: User?
    var usersData: UserDataServiceProtocol?

    init(usersData: UserDataServiceProtocol) {
        self.usersData = usersData
    }

    func exitAccount() async {
        do {
            try await FirebaseAuthManager.shared.logoutUser()
            CoreDataManager.shared.clearAllData()

            await MainActor.run {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = UIHostingController(rootView: LoginView())
                    window.makeKeyAndVisible()
                }
            }

        } catch {
            print("Failed to logout: \(error.localizedDescription)")
        }
    }

    func setCurrentUser() {
        currentUser = usersData?.getCurrentUser()
    }
}
