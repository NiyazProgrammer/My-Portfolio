import Foundation
import UIKit

protocol UserDataServiceProtocol {
    func getCurrentUser() -> User
    func setupCurrentUser()
    func setAvatarImageUserWithDB()
    func setAvatarImageUser(image: UIImage)
    var observerCurrentUser: ((User) -> Void)? { get set }
}
