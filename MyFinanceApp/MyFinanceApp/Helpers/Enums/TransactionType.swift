import Foundation

enum TransactionType: String, CaseIterable, Codable {
    case expense = "Расход"
    case income = "Доход"
}
