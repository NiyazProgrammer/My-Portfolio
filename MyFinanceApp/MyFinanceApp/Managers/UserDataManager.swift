import Foundation
import UIKit
import Combine

class UserDataManager: UserDataServiceProtocol {
    private var currentUser: User?
    var observerCurrentUser: ((User) -> Void)?

    static var shared: UserDataManager = UserDataManager()
    private init() { }

    func getCurrentUser() -> User {
        return currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: "")
    }

    func setupCurrentUser() {
        let userId = UserDefaultsManager.shared.getUserId()
        FirebaseFirestoreManager.shared.getUser(collection: "users", docName: userId) { [weak self] user in
            if let newUser = user {
                self?.currentUser = newUser
                self?.setAvatarImageUserWithDB()
            }
        }
    }

    func setAvatarImageUserWithDB() {
        guard let avatarImageUrl = currentUser?.avatarImageUrl else { return }
        FirebaseFirestoreManager.shared.getImage(imageUrl: avatarImageUrl) { [weak self] image in
            if let image = image {
                self?.currentUser?.avatarImageUrl = avatarImageUrl
                self?.observerCurrentUser?(self?.currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: ""))
            }
        }
    }

    func setAvatarImageUser(image: UIImage) {
        guard let imageData = image.pngData() else { return }
        FirebaseFirestoreManager.shared.setImageAvatar(imageData: imageData) { [weak self] result in
            switch result {
            case .success(let imageUrl):
                self?.currentUser?.avatarImageUrl = imageUrl
                self?.updateUserAvatarUrlInDB(imageUrl: imageUrl)
            case .failure(let error):
                print("Error uploading image: \(error)")
            }
        }
    }

    private func updateUserAvatarUrlInDB(imageUrl: String) {
        guard let userId = currentUser?.id else { return }
        FirebaseFirestoreManager.shared.updateUserAvatarUrl(userId: userId, imageUrl: imageUrl) { [weak self] success in
            if success {
                self?.observerCurrentUser?(self?.currentUser ?? User(id: nil, email: "", userName: "", avatarImageUrl: nil, password: ""))
            }
        }
    }
}
