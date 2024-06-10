import Foundation

class EditCardViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var selectedCurrency: String = ""
    @Published var selectedIcon: String = ""
    @Published var selectedBackground: String = ""
    @Published var selectedBalance: String = ""

    private let repository: BankCardRepositoryProtocol

    init(with card: BankCard, repository: BankCardRepositoryProtocol) {
        self.repository = repository
        name = card.name
        selectedIcon = card.labelImage
        selectedBackground = card.backImage
        selectedBalance = String(describing: card.totalMoney)
    }

    func updateCard() {
        repository.addBankCard(BankCard(id: UUID(),
                                        name: self.name,
                                        backImage: selectedBackground,
                                        totalMoney: Double(selectedBalance) ?? 0.0,
                                        labelImage: selectedIcon))
    }
}
