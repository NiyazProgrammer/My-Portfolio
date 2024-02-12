import CoreData
import UIKit

protocol UpdateDataEverythingControllers: AnyObject {
    func updateData()
}
class UserCoreDataManager {
    weak var delegate: UpdateDataEverythingControllers?
    weak var delegate1: UpdateDataEverythingControllers?
    weak var delegate2: UpdateDataEverythingControllers?
    var user: User?
//    var users: [User] = []
    let userDefaults = UserDefaults(suiteName: "CurrentUserNickName")
    static let shared = UserCoreDataManager()
    var fetchedResultController: NSFetchedResultsController<User>!

    private init() {
        //deleteAllData()
        fetchedResultController = SystemCoreDataMethods.shared.createAndSetFetchedResultController()
        obtainDefaultUsers()
    }
    func deleteAllData() {
        let fetchRequest = User.fetchRequest()
        do {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as? NSFetchRequest<NSFetchRequestResult> ?? NSFetchRequest())
            try SystemCoreDataMethods.shared.viewContext.execute(batchDeleteRequest)
            SystemCoreDataMethods.shared.saveContext()
        } catch {
            print("Ошибка при Delete: \(error)")
        }
    }

    func obtainDefaultUsers() {
        if (obtainAllUsers().first(where: {$0.nickName == "Cat1"}) == nil) {
            PublicationsCoreDataManager.shared.obtainDefaultPublications()
            var user1 = User(context: SystemCoreDataMethods.shared.viewContext)
            user1.nickName = "Cat1"
            user1.fullName = "Cat junior"
            user1.password = "123"
            user1.imageAvatarData = UIImage(named: "photo1")?.pngData()
            user1.numberSubscribers = 100
            user1.numberSubscriptions = 500
            user1.descriptions = "I am junior developer"
            for publication in PublicationsCoreDataManager.shared.publications1 {
                user1.addToPublications(publication)
            }

            var user2 = User(context: SystemCoreDataMethods.shared.viewContext)
            user2.nickName = "Cat2"
            user2.fullName = "Cat middle"
            user2.password = "123"
            user2.imageAvatarData = UIImage(named: "photo2")?.pngData()
            user2.numberSubscribers = 500
            user2.numberSubscriptions = 300
            user2.descriptions = "I am middle developer"
            for publication in PublicationsCoreDataManager.shared.publications2 {
                user2.addToPublications(publication)
            }

            var user3 = User(context: SystemCoreDataMethods.shared.viewContext)
            user3.nickName = "Cat3"
            user3.fullName = "Cat senior"
            user3.password = "123"
            user3.imageAvatarData = UIImage(named: "photo3")?.pngData()
            user3.numberSubscribers = 2200
            user3.numberSubscriptions = 200
            user3.descriptions = "I am senior developer"
            for publication in PublicationsCoreDataManager.shared.publications3 {
                user3.addToPublications(publication)
            }

            user1.addToSubscriptions(user2)
            user2.addToSubscriptions(user1)
            user3.addToSubscriptions(user1)
            user3.addToSubscriptions(user2)

//            users.append(user1)
//            users.append(user2)
//            users.append(user3)
        } else {
//            users += obtainAllUsers()
            PublicationsCoreDataManager.shared.getAllPosts()
        }
        //SystemCoreDataMethods.shared.saveContext()
    }

    private func asyncCheckedUserValidation(nickName: String, password: String) async -> User? {
        do {
            try fetchedResultController.performFetch() // Вызываем performFetch на NSFetchedResultsController
            guard let users = fetchedResultController.fetchedObjects else { return nil }
            if let user = users.first(where: { $0.nickName == nickName && $0.password == password }) {
                return user
            } else {
                return nil
            }
        }
        catch{
            print("Error fetch Request: \(error)")
            return nil
        }
    }

    func getCurrentUser() async -> User? {
        return UserCoreDataManager.shared.user
    }
    func tryLogin(nickName: String, password: String) async {
        guard let newUser = await self.asyncCheckedUserValidation(nickName: nickName, password: password) else { return }
        let publication = await PublicationsCoreDataManager.shared.asyncPublicationCurrentUser(user: newUser)
        UserCoreDataManager.shared.user = newUser
        //UserCoreDataManager.shared.user?.publications = Set(publication)
    }
    func saveAuthorisationUser() {
        let currentUserNickName = (UserCoreDataManager.shared.user?.nickName)
        userDefaults?.set(currentUserNickName, forKey: "CurrentUserNickName")
    }
    func obtainAuthorisationUser() -> User {
        if let userNickNameString = userDefaults?.string(forKey: "CurrentUserNickName") {
            var users = fetchedResultController.fetchedObjects
            if let user = users?.first(where: { $0.nickName == userNickNameString }) {
                return user
            }
        }
        return User(context: SystemCoreDataMethods.shared.viewContext)
    }

    func obtainAllUsers() -> [User] {
        return fetchedResultController.fetchedObjects ?? []
    }

    func checkUserInCoreData(nickName: String) -> Bool {
        return (fetchedResultController.fetchedObjects?.first(where: { $0.nickName == nickName }) != nil)
    }

    func saveNewRegistrationUser(user: User) {
        SystemCoreDataMethods.shared.saveContext()
    }
}
