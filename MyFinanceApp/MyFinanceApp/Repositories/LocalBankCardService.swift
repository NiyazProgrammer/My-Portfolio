import Foundation
import CoreData

enum DataBaseError: Error {
    case fetchByCoreDataError
    case canNotDeleteBankCardError
    case canNotUpdateBankCardError
}
class LocalBankCardService: NSObject, BankCardServiceProtocol {

    let fetchedResultsController: NSFetchedResultsController<BankCardData>

    override init() {
        let fetchRequest: NSFetchRequest<BankCardData> = BankCardData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        super.init()

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to fetch bank cards: \(error)")
        }
    }

    func fetchBankCards(completion: @escaping ((Result<[BankCard], Error>) -> Void)) {
        if let bankCardsData = self.fetchedResultsController.fetchedObjects {
            let result = bankCardsData.map { BankCard(from: $0) }
            DispatchQueue.main.async {
                completion(.success(result))
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(DataBaseError.fetchByCoreDataError))
            }
        }
    }

    func addBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        CoreDataManager.shared.viewContext.createBankCard(from: card)
        CoreDataManager.shared.saveContext()
        DispatchQueue.main.async {
            completion(.success(true))
        }
    }

    func updateBankCard(_ bankCard: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        if let currentCard = self.fetchedResultsController.fetchedObjects?.first(where: { $0.id == bankCard.id }) {
            currentCard.name = bankCard.name
            currentCard.backImage = bankCard.backImage
            currentCard.totalMoney = bankCard.totalMoney
            currentCard.icon = bankCard.labelImage

            CoreDataManager.shared.saveContext()
            DispatchQueue.main.async {
                completion(.success(true))
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(DataBaseError.canNotUpdateBankCardError))
            }
        }
    }

    func deleteBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {  [weak self] in
            if let currentCard = self?.fetchedResultsController.fetchedObjects?.first(where: { $0.id == card.id }) {
                CoreDataManager.shared.viewContext.delete(currentCard)
                CoreDataManager.shared.saveContext()
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(DataBaseError.canNotDeleteBankCardError))
                }
            }
        }
    }
}

