//
//  SystemCoreDataMethods.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 14.12.2023.
//

import Foundation
import CoreData

class SystemCoreDataMethods {

    static let shared = SystemCoreDataMethods()

    private init() {}

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

//    var backgroundContext: NSManagedObjectContext {
//        return persistentContainer.newBackgroundContext()
//    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MainCoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        // проверка что есть изменения
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createAndSetFetchedResultController() -> NSFetchedResultsController<User> {
        let userFetchRequest = User.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "nickName", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptors]

        let resultController = NSFetchedResultsController(
            fetchRequest: userFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        do {
            try resultController.performFetch()
        }
        catch {
            print("Fetch request failed with error: \(error)")
        }

        return resultController
    }

    func deletePublication(_ publication: Publication) throws {
        viewContext.delete(publication)

        // проверка что есть изменения
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }
    func deleteUser(_ user: User) throws {
        viewContext.delete(user)

        // проверка что есть изменения
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }

}
