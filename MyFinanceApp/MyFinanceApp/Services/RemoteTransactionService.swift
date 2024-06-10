import Foundation
import Firebase

class RemoteTransactionService: TransactionRepositoryProtocol {
    func fetchTransactionsByCardId(for cardId: UUID, completion: @escaping ([Transaction]) -> Void) {

    }
    
    func addTransactionByCard(for card: BankCard, _ transaction: Transaction) {
        DispatchQueue.global(qos: .userInitiated).async {
            let userId = UserDefaultsManager.shared.getUserId()
            let db = Firestore.firestore()
            let userRef = db.collection("bank-cards").document(String(describing: userId))
            let cardRef = db.collection("cards").document(String(describing: card.id))
            let transactionData: [String: Any] = [
                "id": transaction.id.uuidString,
                "name": transaction.name,
                "date": transaction.date,
                "price": transaction.price,
                "type": transaction.type.rawValue,
                "transactionCategory": transaction.category.rawValue
            ]

            cardRef
                .collection("transactions")
                .document(String(describing: transaction.id))
                .setData(transactionData) { error in
                if let error = error {
                    print("Error adding transaction: \(error)")
                } else {
                    print("Transaction added successfully")
                }
            }
        }
    }

    func deleteTransaction(for card: BankCard, _ transaction: Transaction) {

    }

    func fetchTransactions(for card: BankCard, completion: @escaping ([Transaction]) -> Void) {

    }

    func fetchTransactionsByCardId(for cardId: UUID, completion: @escaping (Transaction) -> Void) {
        
    }

}
