import Foundation
import UIKit

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var username: String = ""
    @Published var showPassword: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var showLoading: Bool = false

    func registerUser() async {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !username.isEmpty else {
            DispatchQueue.main.async {
                self.alertMessage = "Пожалуйста заполните все поля"
                self.showAlert = true
            }
            return
        }

        guard password == confirmPassword else {
            DispatchQueue.main.async {
                self.alertMessage = "Passwords do not match"
                self.showAlert = true
            }
            return
        }

        do {
            let user = try await FirebaseAuthManager.shared.registerUser(email: email, password: password, userName: username)
            DispatchQueue.main.async {
                self.isAuthenticated = true
                self.showLoading = true
            }
        } catch {
            DispatchQueue.main.async {
                self.alertMessage = error.localizedDescription
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
