import Foundation

protocol UsersProtocol: AnyObject {
    func asyncCheckedUser(login: String, password: String, completion: @escaping (User?) -> Void)
}
