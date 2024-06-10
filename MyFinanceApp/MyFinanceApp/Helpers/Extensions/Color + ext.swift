import Foundation
import SwiftUI

extension Color {
    static func color(for category: TransactionCategory) -> Color {
        switch category {
        case .expense(let expenseCategory):
            switch expenseCategory {
            case .food:
                return .orange
            case .housing:
                return .yellow
            case .education:
                return .purple
            case .transport:
                return .brown
            case .bank:
                return .black.opacity(0.5)
            case .career:
                return .red
            case .charity:
                return .green
            case .subscriptions:
                return .purple
            case .health:
                return .red
            case .clothing:
                return .green
            case .holidays:
                return .green
            case .technique:
                return .orange
            case .car:
                return .purple
            case .business:
                return .black
            case .flowers:
                return .pink
            case .children:
                return .blue
            case .house:
                return .green
            case .selfCare:
                return .blue
            case .services:
                return .pink
            case .entertaiment:
                return .purple
            case .travel:
                return .orange
            case .goalsAndDesires:
                return .black
            case .others:
                return .gray
            }
        case .income(let incomeCategory):
            switch incomeCategory {
            case .business:
                return .black
            case .salary:
                return .green
            case .topUp:
                return .blue
            case .bonus:
                return .yellow
            case .gifts:
                return .pink
            case .pension:
                return .purple
            }
        }
    }
}
