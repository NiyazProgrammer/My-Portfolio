import Foundation

protocol BankCardServiceProtocol {
    func fetchBankCards(handler: @escaping ((Result<[BankCard], Error>) -> Void))
    func addBankCard(_ card: BankCard)
    func deleteBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void))
    func updateBankCard(_ bankCard: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void))
}

protocol BankCardRepositoryProtocol {
    var onChange: (() -> Void)? { get set }
    func fetchBankCards(handler: @escaping ((Result<[BankCard], Error>) -> Void))
    func addBankCard(_ card: BankCard)
    func deleteBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void))
    func updateBankCard(_ bankCard: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void))
}
