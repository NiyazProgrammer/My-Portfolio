import Foundation

class AddTransactionViewModel: ObservableObject {
    @Published var selectedTransactionType: TransactionType = .expense
    @Published var amount: String = ""
    @Published var description: String = ""
    @Published var selectedTypeCategory: TransactionCategory?
    @Published var showTypePicker: Bool = false
    @Published var selectedDate: Date = Date()
    @Published var showDatePicker: Bool = false
    private var selectedBankCard: BankCard

    private let repository: TransactionRepositoryProtocol

    init(selectedCard: BankCard, repository: TransactionRepositoryProtocol) {
        self.repository = repository
        selectedBankCard = selectedCard
    }

    var categories: [TransactionCategory] {
        switch selectedTransactionType {
        case .expense:
            return TransactionExpenseCategory.allCases.map {
                TransactionCategory.expense($0)
            }
        case .income:
            return TransactionIncomeCategory.allCases.map {
                TransactionCategory.income($0)
            }
        }
    }

    func updateSelectedCategory(_ category: String) {
        switch selectedTransactionType {
        case .expense:
            guard let category = TransactionExpenseCategory(rawValue: category) else { return }
            selectedTypeCategory = .expense(category)
        case .income:
            guard let category = TransactionIncomeCategory(rawValue: category) else { return }
            selectedTypeCategory = .income(category)
        }
    }

    func addTransaction() {
        guard isFormValid() else { return }

        let transaction = Transaction(
            id: UUID(),
            name: selectedTransactionType.rawValue,
            date: DateFormatter.dateFormatter.string(from: selectedDate),
            price: Double(amount) ?? 0.0,
            type: selectedTransactionType,
            category: selectedTypeCategory ?? .expense(.others)
        )

        repository.addTransactionByCard(for: selectedBankCard, transaction)
    }

    func isFormValid() -> Bool {
        return !amount.isEmpty && selectedTypeCategory != nil
    }
}
