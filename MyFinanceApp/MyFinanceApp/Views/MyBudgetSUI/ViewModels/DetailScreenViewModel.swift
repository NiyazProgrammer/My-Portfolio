import Foundation
import SwiftUI

struct PieChartData {
    let id: UUID
    let color: Color
    let amount: Double
    var percent: CGFloat
    var value: CGFloat
}

typealias TransactionGroup = [String: [Transaction]]

final class DetailScreenViewModel: ObservableObject {
    @Published var currentChartData: [PieChartData] = []
    @Published var currentMonth: String
    @Published var currentTypeTransactions: TransactionType = .expense {
        didSet {
            updateCurrentTransactionsInfoByType()
        }
    }

    private var currentMonthIndex: Int
    private var filteredTransactions: [Transaction] = []
    var selectedBankCard: BankCard

    @Published var transactions: [Transaction] = []

    private var availableMonths: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        let monthSymbols = formatter.monthSymbols
        let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        return Array(monthSymbols?[0...currentMonthIndex] ?? [])
    }

    // MARK: Formatted date in mouth
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()

    init(bankCard: BankCard) {
        selectedBankCard = bankCard
        currentMonth = dateFormatter.string(from: Date())
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        updateCurrentTransactionsInfoByType()
    }

    func switchNextMonth() {
        if currentMonthIndex < availableMonths.count - 1 {
            currentMonthIndex += 1
            currentMonth = availableMonths[currentMonthIndex]
            updateCurrentTransactionsInfoByType()
        }
    }

    func switchPreviousMonth() {
        if currentMonthIndex > 0 {
            currentMonthIndex -= 1
            currentMonth = availableMonths[currentMonthIndex]
            updateCurrentTransactionsInfoByType()
        }
    }

    private func generatePieChartData() -> [PieChartData] {
        let newFilteredTransactions = filteredTransactions.filter { $0.type == currentTypeTransactions }
        var chartData: [PieChartData] = []

        // MARK: Группировка транзакций по категориям
        let groupedTransactions = Dictionary(grouping: newFilteredTransactions, by: { $0.category })

        // MARK: Создание данных для круговой диаграммы
        for (category, transactions) in groupedTransactions {
            let totalAmount = transactions.reduce(0.0) { $0 + $1.price }
            chartData.append(PieChartData(id: UUID(), color: Color.color(for: category), amount: totalAmount, percent: 0.0, value: 0.0))
        }
        return chartData
    }

    private func calcForChartValue() {
        calcChartValue(for: &currentChartData)
    }

    private func calcChartValue(for chartData: inout [PieChartData]) {
        var value: CGFloat = 0

        for index in 0..<chartData.count {
            value += chartData[index].percent
            chartData[index].value = value
        }
    }

    func updateCurrentTransactionsInfoByType() {
        setupFiltersForTransactionsByType()
        setupChartDataByType()
    }

    private func filterTransactionsByMonth() {
        filteredTransactions = filteredTransactions.filter { transaction in
            let month = Calendar.current.component(.month, from: transaction.dateParsed)
            return month == currentMonthIndex + 1
        }
    }

    private func setupFiltersForTransactionsByType() {
        filteredTransactions = selectedBankCard.transactions?.filter { $0.type == currentTypeTransactions} ?? []
        filterTransactionsByMonth()
    }

    private func setupChartDataByType() {
        currentChartData = generatePieChartData()
        let total = currentChartData.reduce(0.0) { $0 + $1.amount }
        for index in currentChartData.indices {
            currentChartData[index].percent = CGFloat(currentChartData[index].amount / total)
        }
        calcForChartValue()
    }

    func groupTransactionsByDay() -> TransactionGroup {
        guard !filteredTransactions.isEmpty else { return [:] }
        return TransactionGroup(grouping: filteredTransactions, by: { $0.createDay })
    }

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        updateCurrentTransactionsInfoByType()
    }
}
