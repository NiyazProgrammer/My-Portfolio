import Foundation

class AddCardViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var selectedCurrency: String = "Российский рубль"
    @Published var selectedIcon: String = "defaultIcon"
    @Published var selectedBackground: String = "defaultBackground"
    @Published var selectedBalance: String = "0,00"

    private let repository: BankCardRepositoryProtocol

    init(repository: BankCardRepositoryProtocol) {
        self.repository = repository
    }

    func saveCard() {
        repository.addBankCard(
            BankCard(
                id: UUID(),
                name: self.name,
                backImage: selectedBackground,
                totalMoney: Double(selectedBalance) ?? 0.0,
                labelImage: selectedIcon
            )
        )
    }
}
