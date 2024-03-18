import UIKit

class DataManager {
    static let shared = DataManager()

    private init() {
        createUsers()
    }

    var users: [User] = []

    private func  createUsers() {
        let user1 = User(context: SystemCoreDataMethods.shared.viewContext)
        user1.name = "Steve"
        user1.lastname = "Medan"
        user1.age = 21
        user1.aboutMe = "I am businessman and I am very busy"
        user1.university = "Kfu University"
        user1.photo = UIImage(named: "billionerman")?.pngData()
        user1.job = "Businessman"
        user1.city = "Kazan"
        users.append(user1)

        let user2 = User(context: SystemCoreDataMethods.shared.viewContext)
        user2.name = "Mela"
        user2.lastname = ""
        user2.age = 22
        user2.aboutMe = "I am Photograph"
        user2.university = "Cambridge University"
        user2.photo = UIImage(named: "beautyWoman")?.pngData()
        user2.job = "Photograph"
        user2.city = "Moscow"
        users.append(user2)

        let user3 = User(context: SystemCoreDataMethods.shared.viewContext)
        user3.name = "Alexsandr"
        user3.lastname = "Radulov"
        user3.age = 23
        user3.aboutMe = "I am hockey player of the AkBars team"
        user3.university = "Cambridge University"
        user3.photo = UIImage(named: "radulov")?.pngData()
        user3.job = "Hockey player"
        user3.city = "Kazan"
        users.append(user3)

        let user4 = User(context: SystemCoreDataMethods.shared.viewContext)
        user4.name = "Cristiano"
        user4.lastname = "Ronaldo"
        user4.age = 24
        user4.aboutMe = "I am the greatest football player in the world"
        user4.university = "Cambridge University"
        user4.photo = UIImage(named: "footboller")?.pngData()
        user4.job = "Football player"
        user4.city = "Spain"
        users.append(user4)

        let user5 = User(context: SystemCoreDataMethods.shared.viewContext)
        user5.name = "Niyaz"
        user5.lastname = ""
        user5.age = 19
        user5.aboutMe = "I am IOS developer. I want to gain experience in development and become a good software architect."
        user5.university = "KFU University"
        user5.photo = UIImage(named: "programmer")?.pngData()
        user5.job = "Programmer"
        user5.city = "Kazan"
        users.append(user5)

    }
}
