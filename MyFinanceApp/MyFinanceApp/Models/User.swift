import UIKit

struct User: Codable {
    var id: String?
    var email: String
    var userName: String
    var avatarImageUrl: String?
    var password: String
}
