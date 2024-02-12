//
//  User+CoreDataProperties.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 20.12.2023.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    // делаем что хотим
}

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var fullName: String?
    @NSManaged public var nickName: String?
    @NSManaged public var numberSubscriptions: Int32
    @NSManaged public var numberSubscribers: Int32
    @NSManaged public var numberPublication: Int32
    @NSManaged public var imageAvatarData: Data?
    @NSManaged public var descriptions: String?
    @NSManaged public var subscriptions: Set<User>?
    @NSManaged public var subscribers: Set<User>?
    @NSManaged public var publications: Set<Publication>?

}

// MARK: Generated accessors for subscriptions
extension User {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: User)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: User)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}

// MARK: Generated accessors for publications
extension User {

    @objc(addPublicationsObject:)
    @NSManaged public func addToPublications(_ value: Publication)

    @objc(removePublicationsObject:)
    @NSManaged public func removeFromPublications(_ value: Publication)

    @objc(addPublications:)
    @NSManaged public func addToPublications(_ values: NSSet)

    @objc(removePublications:)
    @NSManaged public func removeFromPublications(_ values: NSSet)

}

extension User : Identifiable {

}
