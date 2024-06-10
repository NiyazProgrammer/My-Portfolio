import Foundation
import UIKit

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var showLoading: Bool = false

    func loginUser() async {
        guard !email.isEmpty, !password.isEmpty else {
            DispatchQueue.main.async {
                self.alertMessage = "Пожалуйста ввидете все поля!"
                self.showAlert = true
            }
            return
        }

        do {
            let user = try await FirebaseAuthManager.shared.loginUser(email: email, password: password)
            DispatchQueue.main.async {
                self.isAuthenticated = UserDefaultsManager.shared.getStatus()
                if self.isAuthenticated {
                    self.showLoading = true
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.alertMessage = "Логин или пароль введены не верно" 
                self.showAlert = true
            }
        }
    }

    func goToApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = TabBarController()
                window.makeKeyAndVisible()
            }
        }
    }
}
