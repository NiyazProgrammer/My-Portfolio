//
//  Publication+CoreDataProperties.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 20.12.2023.
//
//

import Foundation
import CoreData

@objc(Publication)
public class Publication: NSManagedObject {
    // делаем что хотим
}

extension Publication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publication> {
        return NSFetchRequest<Publication>(entityName: "Publication")
    }

    @NSManaged public var date: Date?
    @NSManaged public var descriptions: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageAvatarData: Data?
    @NSManaged public var imageData: Data?
    @NSManaged public var label: String?
    @NSManaged public var likes: NSArray?
    @NSManaged public var user: User?

}

extension Publication : Identifiable {

}
