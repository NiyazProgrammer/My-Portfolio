import Foundation
import CoreData

class BankCardRepositoryImpl: NSObject, BankCardRepositoryProtocol {
    var onChange: (() -> Void)?
    private let localService: LocalBankCardService
    private let remoteService: RemoteBankCardService

    init(localService: LocalBankCardService, remoteService: RemoteBankCardService) {
        self.localService = localService
        self.remoteService = remoteService

        super.init()

        localService.fetchedResultsController.delegate = self
    }

    func fetchBankCards(handler: @escaping ((Result<[BankCard], any Error>) -> Void)) {
        localService.fetchBankCards { result in
            switch result {
            case .success(let bankCards):
                handler(.success(bankCards))
            case .failure(let error):
                handler(.failure(error))
            }
        }

        // MARK: Sync with Database
        syncWithRemoteService()
    }

    func fetchBankCardsFromCash(comletion: @escaping ((Result<[BankCard], any Error>) -> Void)) {
        localService.fetchBankCards { result in
            switch result {
            case .success(let bankCards):
                comletion(.success(bankCards))
            case .failure(let error):
                comletion(.failure(error))
            }
        }
    }

    private func syncWithRemoteService() {
        remoteService.fetchBankCards { [weak self] result in
            switch result {
            case .success(let remoteBankCards):
                self?.updateLocalCache(with: remoteBankCards)
                
            case .failure(let error):
                print("Error fetching remote bank cards: \(error)")
            }
        }
    }

    private func updateLocalCache(with remoteBankCards: [BankCard]) {
        let context = CoreDataManager.shared.viewContext
        context.perform { [weak self] in
            for remoteCard in remoteBankCards {
                if let localCard = self?.localService.fetchedResultsController.fetchedObjects?.first(where: { $0.id == remoteCard.id }) {
                    localCard.name = remoteCard.name
                    localCard.backImage = remoteCard.backImage
                    localCard.totalMoney = remoteCard.totalMoney
                    localCard.icon = remoteCard.labelImage
                } else {
                    context.createBankCard(from: remoteCard)
                }
            }
            CoreDataManager.shared.saveContext()
        }
    }

    func addBankCard(_ card: BankCard) {
        localService.addBankCard(card) { result in
            print("Карта успешно добавлена в кэш")
            // MARK: Требует обработки
        }
        remoteService.addBankCard(card) { result in
            print("Карта успешно добавлена в базу данных")
            // MARK: Требует обработки
        }
    }

    func deleteBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, any Error>) -> Void)) {
        localService.deleteBankCard(card) { [weak self] localResult in
            switch localResult {
            case .success:
                self?.remoteService.deleteBankCard(card) { remoteResult in
                    completion(remoteResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateBankCard(_ bankCard: BankCard, completion: @escaping ((Result<Bool, any Error>) -> Void)) {
        localService.updateBankCard(bankCard) { [weak self] localResult in
            switch localResult {
            case .success:
                self?.remoteService.updateBankCard(bankCard) { remoteResult in
                    completion(remoteResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
extension BankCardRepositoryImpl: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onChange?()
    }
}
