import SwiftUI
import Foundation

struct CategoryIconView: View {
    var category: TransactionCategory

    var body: some View {
        let color = Color.color(for: category)

        return ZStack {
            Circle()
                .foregroundStyle(color.opacity(0.5))
                .frame(width: 40, height: 40)
            Image(systemName: getIconName(for: category))
                .resizable()
                .frame(width: 20, height: 20)
        }
    }

    private func getIconName(for category: TransactionCategory) -> String {
        switch category {
        case .expense(let expenseCategory):
            switch expenseCategory {
            case .food:
                return "fork.knife"
            case .housing:
                return "house.fill"
            case .education:
                return "book.fill"
            case .transport:
                return "car.fill"
            case .bank:
                return "banknote.fill"
            case .career:
                return "briefcase.fill"
            case .charity:
                return "hand.raised.fingers.spread.fill"
            case .subscriptions:
                return "newspaper.fill"
            case .health:
                return "heart.fill"
            case .clothing:
                return "tshirt.fill"
            case .holidays:
                return "gift.fill"
            case .technique:
                return "iphone.gen2"
            case .car:
                return "car.fill"
            case .business:
                return "building.fill"
            case .flowers:
                return "camera.macro"
            case .children:
                return "figure.2"
            case .house:
                return "house.fill"
            case .selfCare:
                return "hands.and.sparkles"
            case .services:
                return "staroflife.fill"
            case .entertaiment:
                return "gamecontroller.fill"
            case .travel:
                return "airplane"
            case .goalsAndDesires:
                return "star.fill"
            case .others:
                return "book.pages"
            }
        case .income(let incomeCategory):
            switch incomeCategory {
            case .business:
                return "building.fill"
            case .salary:
                return "dollarsign.circle.fill"
            case .topUp:
                return "plus.circle.fill"
            case .bonus:
                return "star.circle.fill"
            case .gifts:
                return "gift.fill"
            case .pension:
                return "dollarsign.arrow.circlepath"
            }
        }
    }
}
