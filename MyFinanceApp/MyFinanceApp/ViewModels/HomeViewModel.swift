import Foundation

class HomeViewModel: ObservableObject {
    @Published var bankCards: [BankCard] = []
    @Published var currencies: [Valute] = []
    @Published var totalMoney: Double = 0.0
    @Published var currentUser: User?

    var usersData: UserDataServiceProtocol?

    private var bankCardRepository: BankCardRepositoryProtocol

    init(bankCardRepository: BankCardRepositoryProtocol,usersData: UserDataServiceProtocol) {
        self.bankCardRepository = bankCardRepository
        self.usersData = usersData
        fetchBankCards()
        fetchCurrencies()
    }

    func fetchBankCards() {
        bankCardRepository.fetchBankCards { [weak self] result in
            switch result {
            case .success(let bankCards):
                DispatchQueue.main.async {
                    self?.bankCards = bankCards
                    self?.fetchTotalMoney()
                }
            case .failure(let error):
                print("Error fetching bank cards: \(error)")
            }
        }
    }

    func fetchCurrencies() {
        let manager = CurrencyNetworkingManager()
        manager.obtainCoins { [weak self] result in
            switch result {
            case .success(let coin):
                if let valute = coin.valute {
                    var accessCurrencies: [Valute] = []
                    for (_, value) in valute {
                        if Resources.Strings.currencies.contains(value.charCode) {
                            accessCurrencies.append(value)
                        }
                    }
                    self?.currencies = accessCurrencies
                } else {
                    print("No currencies found.")
                }
            case .failure(let error):
                print("Ошибка: \(error)")
            }
        }
    }

    private func fetchTotalMoney() {
        totalMoney = bankCards.reduce(0.0) { $0 + $1.totalMoney}
    }

    func setCurrentUser() {
        currentUser = usersData?.getCurrentUser()
    }
}
