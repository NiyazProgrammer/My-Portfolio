import Foundation
import SwiftUI

struct Transaction: Identifiable, Codable {
    var id: UUID
    let name: String
    let date: String
    let price: Double
    let type: TransactionType
    let category: TransactionCategory
    var descriptions: [TransactionDescriptionsModel] = []

    init(from transactionData: TransactionData) {
        self.id = transactionData.id
        self.name = transactionData.name
        self.date = transactionData.date
        self.price = transactionData.price

        if let transactionType = TransactionType(rawValue: transactionData.type) {
            self.type = transactionType
        } else {
            self.type = .expense
        }

        if let expenseCategory = TransactionExpenseCategory(rawValue: transactionData.transactionCategory) {
            self.category = .expense(expenseCategory)
        } else if let incomeCategory = TransactionIncomeCategory(rawValue: transactionData.transactionCategory) {
            self.category = .income(incomeCategory)
        } else {
            self.category = .expense(.others)
        }

        self.descriptions = []
    }

    init(id: UUID, name: String, date: String, price: Double, type: TransactionType, category: TransactionCategory) {
        self.id = id
        self.name = name
        self.date = date
        self.price = price
        self.type = type
        self.category = category
    }

    var dateParsed: Date {
        date.dateParse()
    }

    var signedAmount: Double {
        return type == TransactionType.income ? price : -price
    }

    //    MARK: Преобразует дату в вид January 18, 2024
    var createDay: String {
        dateParsed.formatted(.dateTime.day().month(.wide))
    }

    var createMonth: String {
        dateParsed.formatted(.dateTime.month(.wide))
    }
}
