//
//  TransactionRepository.swift
//  MyFinanceApp
//
//  Created by Нияз Ризванов on 28.05.2024.
//

import Foundation

protocol TransactionRepositoryProtocol {
    func addTransactionByCard(for card: BankCard, _ transaction: Transaction)
    func deleteTransaction(for card: BankCard, _ transaction: Transaction)
    func fetchTransactions(for card: BankCard, completion: @escaping ([Transaction]) -> Void)
    func fetchTransactionsByCardId(for cardId: UUID, completion: @escaping ([Transaction]) -> Void)
}
