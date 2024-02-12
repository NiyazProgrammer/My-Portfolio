import UIKit
import CoreData

class PublicationsCoreDataManager: PublicationProtocol {
    static let shared = PublicationsCoreDataManager()
    //private let userDefaults = UserDefaults(suiteName: "users")

    var isCallObserver: Bool = true
   // var dictionaryUserAndPublication: [String: [ Publication ]] = [ : ]
    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    var dateFormatter = DateFormatter()

    var publicationsCurrentUser: [Publication] = [] {
        willSet {
            PublicationsCoreDataManager.shared.isCallObserver = false
        }
        didSet {
            UserCoreDataManager.shared.user?.publications = Set(publicationsCurrentUser)
            UserCoreDataManager.shared.delegate?.updateData()
            UserCoreDataManager.shared.delegate1?.updateData()
            UserCoreDataManager.shared.delegate2?.updateData()
        }
    }
    var allPublications: [Publication] = []
    var publications1: [Publication] = []
    var publications2: [Publication] = []
    var publications3: [Publication] = []
    private init() {
        
    }
    func obtainDefaultPublications() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let publication1 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication1.id = UUID()
        publication1.imageAvatarData = UIImage(named: "photo1")?.pngData()
        publication1.label = "Cat1"
        publication1.descriptions = "Это я)"
        publication1.date = dateFormatter.date(from: "2023-11-20")
        publication1.imageData = UIImage(named: "photo1")?.pngData()
        publication1.likes = []

        let publication2 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication2.id = UUID()
        publication2.imageAvatarData = UIImage(named: "photo1")?.pngData()
        publication2.label = "Cat1"
        publication2.descriptions = "Заработал денег)"
        publication2.date = dateFormatter.date(from: "2023-11-22")
        publication2.imageData = UIImage(named: "photo1_2")?.pngData()
        publication2.likes = []

        let publication3 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication3.id = UUID()
        publication3.imageAvatarData = UIImage(named: "photo2")?.pngData()
        publication3.label = "Cat2"
        publication3.descriptions = "Это я)"
        publication3.date = dateFormatter.date(from: "2023-11-20")
        publication3.imageData = UIImage(named: "photo2")?.pngData()
        publication3.likes = []

        let publication4 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication4.id = UUID()
        publication4.imageAvatarData = UIImage(named: "photo2")?.pngData()
        publication4.label = "Cat2"
        publication4.descriptions = "Я плохой кот"
        publication4.date = dateFormatter.date(from: "2023-11-23")
        publication4.imageData = UIImage(named: "photo2_2")?.pngData()
        publication4.likes = []

        let publication5 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication5.id = UUID()
        publication5.imageAvatarData = UIImage(named: "photo3")?.pngData()
        publication5.label = "Cat3"
        publication5.descriptions = "Это я)"
        publication5.date = dateFormatter.date(from: "2023-11-23")
        publication5.imageData = UIImage(named: "photo3")?.pngData()
        publication5.likes = []

        let publication6 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication6.id = UUID()
        publication6.imageAvatarData = UIImage(named: "photo3")?.pngData()
        publication6.label = "Cat3"
        publication6.descriptions = "Рад всех видеть на своем канале"
        publication6.date = dateFormatter.date(from: "2023-11-24")
        publication6.imageData = UIImage(named: "photo3_2")?.pngData()
        publication6.likes = []

        let publication7 = Publication(context: SystemCoreDataMethods.shared.viewContext)
        publication7.id = UUID()
        publication7.imageAvatarData = UIImage(named: "photo3")?.pngData()
        publication7.label = "Cat3"
        publication7.descriptions = "Типичные будни програмиста)))"
        publication7.date = dateFormatter.date(from: "2023-11-24")
        publication7.imageData = UIImage(named: "photo3_3")?.pngData()
        publication7.likes = []

        publications1 = [publication1, publication2]
        publications2 = [publication3, publication4]
        publications3 = [publication5, publication6, publication7]
        allPublications += publications1 + publications2 + publications3
        SystemCoreDataMethods.shared.saveContext()
    }
    func asyncGetEverythingPublication() async -> [Publication] {
        guard let currentUser = await UserCoreDataManager.shared.getCurrentUser()
        else { return [] }
        var allPosts: [Publication] = []
        for user in currentUser.subscribers ?? [] {
            let publicationsUser = await asyncPublicationCurrentUser(user: user)
            allPosts += publicationsUser
        }
        allPosts += currentUser.publications ?? []
        return allPosts
    }
    func asyncPublicationCurrentUser(user: User) async -> [Publication] {
        var allPost = allPublications
        var currentPublicationsUser = allPost.filter {$0.user?.nickName == user.nickName}
        if isCallObserver {
            publicationsCurrentUser = currentPublicationsUser
        }
        return currentPublicationsUser
    }

    func asyncDelete(_ publication: Publication) {
        deleteQueue.addOperation {
            DispatchQueue.main.async {
                if let publicationId = self.publicationsCurrentUser
                    .firstIndex(where: {$0.id == publication.id}) {
                    SystemCoreDataMethods.shared.viewContext
                        .delete(self.publicationsCurrentUser[publicationId])
                    self.publicationsCurrentUser
                        .remove(at: publicationId)
                    SystemCoreDataMethods.shared.saveContext()
                }
            }
        }
    }
    func asyncFind(withCriteria id: String, completion: @escaping (Publication?) -> Void) {
    }
    func asyncSave(_ publication: Publication, completion: @escaping (Bool) -> Void) {
    }

    func getCountLikes(forPublicationId publicationId: UUID) -> Int {
        let allPost = allPublications
        var post = allPost.first(where: { $0.id == publicationId })
        return post?.likes?.count ?? 0
    }

    func toggleLike(publicationId: UUID, userName: String) {
        DispatchQueue.global().async { [weak self] in
            let allPost = self?.allPublications
            var post = allPost?.first(where: { $0.id == publicationId })
            var likes = (post?.likes as? [String])
            if (post?.likes?.contains(userName) ?? false)  {
                likes?.removeAll {$0 == userName}
            } else {
                likes?.append(userName)
            }
            post?.likes = likes as? NSArray
            self?.updatePost(post: post)
        }
    }
    func tryLiked(publicationId: UUID, userName: String) -> Bool {
        var isLiked = false
        let allPost = allPublications
        var post = allPost.first(where: { $0.id == publicationId })
        if ((post?.likes?.contains(userName)) ?? false) {
            isLiked = true
        }
        return isLiked
    }

    func createPost(user: User) {
        let newPost = Publication(context: SystemCoreDataMethods.shared.viewContext)
        newPost.id = UUID()
        newPost.label = user.nickName
        newPost.date = Date()
        newPost.likes = []
        newPost.imageData = UIImage(named: "defaultImageAvatar")?.pngData()
        if let imageAvatar = user.imageAvatarData {
            newPost.imageAvatarData = UIImage(data: imageAvatar)?.pngData()
        }
        //dictionaryUserAndPublication[user.nickName ?? ""]?.append(newPost)
        user.addToPublications(newPost)
        publicationsCurrentUser.append(newPost)
        allPublications.append(newPost)
        SystemCoreDataMethods.shared.saveContext()
    }

    func getAllPosts() {
        let fetchRequest = Publication.fetchRequest()
        do {
           allPublications = try SystemCoreDataMethods.shared.viewContext.fetch(fetchRequest)
        } catch {
            print("Ошибка при получении постов: \(error)")
        }
    }
    func deleteAllData() {
        let fetchRequest = Publication.fetchRequest()
        do {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as? NSFetchRequest<NSFetchRequestResult> ?? NSFetchRequest())
            try SystemCoreDataMethods.shared.viewContext.execute(batchDeleteRequest)
            SystemCoreDataMethods.shared.saveContext()
        } catch {
            print("Ошибка при Delete: \(error)")
        }
    }

    func updatePost(post: Publication?) {
        if let indexPostToUpdate = allPublications.firstIndex(where: {$0.id == post?.id}) {
            allPublications[indexPostToUpdate].likes = post?.likes
            SystemCoreDataMethods.shared.saveContext()
        }
    }

//    func deletePost(nickName: String) throws {
//        let allUser = UserCoreDataManager.shared.obtainAllUsers()
//        guard let user = allUser.first(where: {$0.nickName == nickName}) else { return }
//        SystemCoreDataMethods.shared.viewContext.delete(user)
//
//        if SystemCoreDataMethods.shared.viewContext.hasChanges {
//            try SystemCoreDataMethods.shared.viewContext.save()
//        }
//    }
}
