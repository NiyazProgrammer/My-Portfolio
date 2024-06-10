import Foundation
import CoreData

class LocalTransactionService: TransactionRepositoryProtocol {
    func addTransactionByCard(for card: BankCard, _ transaction: Transaction) {
        let context = CoreDataManager.shared.viewContext
        let transactionData = TransactionData(context: context)
        transactionData.id = transaction.id
        transactionData.name = transaction.name
        transactionData.date = transaction.date
        transactionData.price = transaction.price
        transactionData.type = transaction.type.rawValue
        transactionData.transactionCategory = transaction.category.rawValue

        let fetchRequest: NSFetchRequest<BankCardData> = BankCardData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", card.id as CVarArg)

        do {
            if let bankCardData = try context.fetch(fetchRequest).first {
                transactionData.bankCard = bankCardData
                bankCardData.addToTransactions(transactionData)
                // Update the totalMoney of the bank card
                if transaction.type == .income {
                    bankCardData.totalMoney += transaction.price
                } else if transaction.type == .expense {
                    bankCardData.totalMoney -= transaction.price
                }
                try context.save()
            }
        } catch {
            print("Failed to save transaction: \(error)")
        }
    }

    func deleteTransaction(for card: BankCard, _ transaction: Transaction) {

    }

    func fetchTransactions(for card: BankCard, completion: @escaping ([Transaction]) -> Void) {

    }

    func fetchTransactionsByCardId(for cardId: UUID, completion: @escaping ([Transaction]) -> Void) {
        //        let context = CoreDataManager.shared.viewContext
        //                let fetchRequest: NSFetchRequest<TransactionData> = TransactionData.fetchRequest()
        //                fetchRequest.predicate = NSPredicate(format: "bankCard.id == %@", cardId as CVarArg)
        //
        //                do {
        //                    let transactionsData = try context.fetch(fetchRequest)
        //                    let transactions = transactionsData.map { transactionData -> Transaction in
        //                        Transaction(
        //                            id: transactionData.id ?? UUID(),
        //                            name: transactionData.name ?? "",
        //                            date: transactionData.date ?? "",
        //                            price: transactionData.price,
        //                            type: TransactionType(rawValue: transactionData.type ?? "") ?? .expense,
        //                            category: TransactionCategory
        //                        )
        //                    }
        //                    completion(transactions)
        //                } catch {
        //                    print("Failed to fetch transactions: \(error)")
        //                    completion([])
        //                }
    }
}
