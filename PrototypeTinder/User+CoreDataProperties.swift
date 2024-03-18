import CoreData

@objc(User)
public class User: NSManagedObject {

}

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var age: Int32
    @NSManaged public var aboutMe: String?
    @NSManaged public var photo: Data?
    @NSManaged public var university: String?
    @NSManaged public var job: String?
    @NSManaged public var city: String?

}

extension User : Identifiable {

}
