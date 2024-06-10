import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

class FirebaseFirestoreManager {
    static let shared = FirebaseFirestoreManager()

    private func configureFB() -> Firestore {
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }

    private init() {}

    func getUser(collection: String, docName: String, completion: @escaping (User?) -> Void) {
        let dataBase = configureFB()
        dataBase.collection(collection).document(docName).getDocument { document, error in
            guard let document = document, document.exists, error == nil else {
                completion(nil)
                return
            }

            do {
                let user = try document.data(as: User.self)
                completion(user)
            } catch {
                completion(nil)
            }
        }
    }

    func getImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }

        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure:
                completion(nil)
            }
        }
    }

    // swiftlint:disable force_unwrapping
    func setImageAvatar(imageData: Data, completion: @escaping ((Result<String, Error>) -> Void)) {
        let storage = Storage.storage()
        let currentUser = UserDataManager.shared.getCurrentUser()
        let storageRef = storage.reference().child("UsersImage").child((currentUser.id ?? "") + ".png")

        storageRef.putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            storageRef.downloadURL { url, error in
                guard let downloadURL = url, error == nil else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL.absoluteString))
            }
        }
    }

    func updateUserAvatarUrl(userId: String, imageUrl: String, completion: @escaping (Bool) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("users").document(userId).updateData(["avatarImageUrl": imageUrl]) { error in
            completion(error == nil)
        }
    }

    func saveUserToDatabase(_ user: User) async throws {
        guard let userId = user.id else {
            throw NSError(domain: "User ID is nil", code: 0, userInfo: nil)
        }
        try await configureFB().collection("users").document(userId).setData(from: user)
    }

    func fetchUserFromDatabase(uid: String) async throws -> User {
        let snapshot = try await configureFB().collection("users").document(uid).getDocument()
        guard let user = try? snapshot.data(as: User.self) else {
            throw NSError(domain: "User not found", code: 0, userInfo: nil)
        }
        return user
    }

    func deleteUserFromDatabase(uid: String) async throws {
        try await configureFB().collection("users").document(uid).delete()
    }

    func updateUserInDatabase(_ user: User) async throws {
        guard let userId = user.id else {
            throw NSError(domain: "User ID is nil", code: 0, userInfo: nil)
        }
        try await configureFB().collection("users").document(userId).setData(from: user, merge: true)
    }
}

