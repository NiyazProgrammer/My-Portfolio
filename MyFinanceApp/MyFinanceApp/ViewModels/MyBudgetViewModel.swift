import Foundation
import Combine

class MyBudgetViewModel: ObservableObject {
    @Published var bankCards: [BankCard] = []
    @Published var selectedBankCard: BankCard?
    @Published var totalMoney: Double = 0
    @Published var selectedCardIndex = 0

    private var bankCardRepository: BankCardRepositoryProtocol
    private var transactionsRepository: TransactionRepositoryProtocol

    init(bankCardRepository: BankCardRepositoryProtocol, transactionsRepository: TransactionRepositoryProtocol) {
        self.bankCardRepository = bankCardRepository
        self.transactionsRepository = transactionsRepository
        loadData()
    }

    func loadData() {
        bankCardRepository.onChange = { [weak self] in
            self?.bankCardRepository.fetchBankCardsFromCash { result in
                switch result {
                case .success(let bankCards):
                    self?.bankCards = bankCards
                    self?.updateOperationsForSelectedCard()
                    self?.setTotalMoney()
                case .failure(let error):
                    print("Error fetching bank cards: \(error)")
                }
            }
        }
        fetchBankCards()
    }

    func fetchBankCards() {
        self.bankCardRepository.fetchBankCards { [weak self] result in
            switch result {
            case .success(let bankCards):
                self?.bankCards = bankCards
                self?.updateOperationsForSelectedCard()
                self?.setTotalMoney()
            case .failure(let error):
                print("Error fetching bank cards: \(error)")
            }
        }
    }
    
    private func setTotalMoney() {
        totalMoney = bankCards.reduce(0.0) { $0 + $1.totalMoney }
    }

    func updateOperationsForSelectedCard() {
        if !bankCards.isEmpty {
            self.selectedBankCard = bankCards[selectedCardIndex]
        }
    }
}
