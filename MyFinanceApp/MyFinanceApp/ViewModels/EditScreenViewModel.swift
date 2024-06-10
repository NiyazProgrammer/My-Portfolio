import Foundation
import Combine

class EditScreenViewModel {
    @Published var currentUser: User?
    var usersData: UserDataServiceProtocol?

    init(usersData: UserDataServiceProtocol) {
        self.usersData = usersData
        setupBinding()
    }

    func setupBinding() {
        usersData?.observerCurrentUser = { [weak self] updateUser in
            self?.currentUser = updateUser
        }
    }

    func setCurrentUser() {
        currentUser = usersData?.getCurrentUser()
    }
}
