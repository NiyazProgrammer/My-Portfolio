import Foundation
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

class RemoteUserService {
    static let shared = RemoteUserService()

    private init() { }

    private func configureFB() -> Firestore {
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }

    func getUser(collection: String, docName: String, completion: @escaping (User?) -> Void) {
        let dataBase = configureFB()
        dataBase.collection(collection).document(docName).getDocument { document, error in
            guard error == nil else { completion(nil); return }

            let user = User(
                email: document?.get("email") as? String ?? "",
                userName: document?.get("userName") as? String ?? "",
                avatarImageUrl: document?.get("avatarImaheUrl") as? String ?? "defaultAvatar",
                password: document?.get("password") as? String ?? ""
            )
            completion(user)
        }
    }

    func getImage(imageName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("UsersImage")

        let image = UIImage(named: "defaultAvatar")

        let fileRef = pathRef.child(imageName + ".jpg")
        fileRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(image ?? UIImage())
                return
            }
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let imageResult):
                    let loadedImage = imageResult.image
                    completion(loadedImage)
                case .failure(let error):
                    print("Failed to load image: \(error)")
                }
            }
        }
    }

    func setImageAvatar(imageData: Data, completion: @escaping ((Result<Data, Error>) -> Void)) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let pathRef = storageRef.child("UsersImage/file.png")

        pathRef.putData(imageData) { _, error in
            guard let error = error else {
                completion(.success(imageData))
                return
            }
            print("Error uploading image: \(error)")
            completion(.failure(error))
        }
    }
}
