import Foundation
import CoreData

extension NSManagedObjectContext {
    func createBankCard(from newCard: BankCard) {
        let bankCard = BankCardData(context: CoreDataManager.shared.viewContext)

        bankCard.id = newCard.id
        bankCard.name = newCard.name
        bankCard.backImage = newCard.backImage
        bankCard.icon = newCard.labelImage
        bankCard.totalMoney = newCard.totalMoney
        if let transactions = newCard.transactions {
            let transactionDataSet = Set(transactions.map { createTransaction(from: $0) })
            bankCard.transactions = transactionDataSet
        }
    }

    func createTransaction(from newTransaction: Transaction) -> TransactionData {
        let transaction = TransactionData(context: self)

        transaction.id = newTransaction.id
        transaction.name = newTransaction.name
        transaction.date = newTransaction.date
        transaction.price = newTransaction.price
        transaction.type = newTransaction.type.rawValue

        switch newTransaction.category {
        case .expense(let expenseCategory):
            transaction.transactionCategory = expenseCategory.rawValue
        case .income(let incomeCategory):
            transaction.transactionCategory = incomeCategory.rawValue
        }

        return transaction
    }

    func deleteBankCard(from card: BankCard) {

    }

    func createBYtansaction(from newTransaction: Transaction) {

    }

    func deleteTransaction(from transaction: Transaction) {

    }
}
