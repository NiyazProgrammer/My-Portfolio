import Foundation
import Combine

class ProfileViewModel {
    @Published var currentUser: User?
    var usersData: UserDataServiceProtocol?

    init(usersData: UserDataServiceProtocol) {
        self.usersData = usersData
    }

    func setUser() {
        currentUser = usersData?.getCurrentUser()
    }
}
