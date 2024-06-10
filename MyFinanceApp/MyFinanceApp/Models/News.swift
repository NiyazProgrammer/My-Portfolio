import UIKit

struct News {
    let id: Int
    let shortDescription: String
    let date: Date
    var picture: UIImage
    var likesCount: Int
    var likedByUsers: [User]
}
