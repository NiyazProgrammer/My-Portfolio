import Foundation
import Firebase

class RemoteBankCardService: BankCardServiceProtocol {
    private let db = Firestore.firestore()
    private let userId = UserDefaultsManager.shared.getUserId()

    func fetchBankCards(completion: @escaping ((Result<[BankCard], any Error>) -> Void)) {

            let userRef = db.collection("bank-cards").document(userId)

        userRef.collection("cards").getDocuments { (query, error) in
                if let error = error {
                    print("Ошибка при получении банковской карты: \(error.localizedDescription)")

                        completion(.failure(error))
                        return

                }

                var cards: [BankCard] = []

                for document in query?.documents ?? [] {
                    let cardData = document.data()
                    if let cardIdString = cardData["id"] as? String,
                       let cardId = UUID(uuidString: cardIdString),
                       let cardName = cardData["username"] as? String,
                       let backImage = cardData["backImage"] as? String,
                       let totalMoney = cardData["totalMoney"] as? Double,
                       let labelImage = cardData["labelImage"] as? String {
                        let card = BankCard(id: cardId,
                                            name: cardName,
                                            backImage: backImage,
                                            totalMoney: totalMoney,
                                            labelImage: labelImage)
                        cards.append(card)
                    }
                }


                    completion(.success(cards))

            }
    }

    func addBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let userRef = self.db.collection("bank-cards").document(self.userId)
            let cardData: [String: Any] = [
                "id": card.id.uuidString,
                "username": card.name,
                "backImage": card.backImage,
                "totalMoney": card.totalMoney,
                "labelImage": card.labelImage
            ]

            userRef.collection("cards").addDocument(data: cardData) { error in
                if let error = error {
                    print("Ошибка при добавлении банковской карты: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else {
                    print("Банковская карта успешно добавлена")
                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                }
            }
        }
    }

    func deleteBankCard(_ card: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let userRef = self.db.collection("bank-cards").document(self.userId)
            userRef.collection("cards").whereField("id", isEqualTo: card.id.uuidString).getDocuments { querySnapshot, error in
                if let error = error {
                    print("Ошибка при удалении банковской карты: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else if let document = querySnapshot?.documents.first {
                    document.reference.delete { error in
                        if let error = error {
                            print("Ошибка при удалении банковской карты: \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                completion(.failure(error))
                            }
                        } else {
                            print("Банковская карта успешно удалена")
                            DispatchQueue.main.async {
                                completion(.success(true))
                            }
                        }
                    }
                } else {
                    print("Банковская карта не найдена")
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Банковская карта не найдена"])))
                    }
                }
            }
        }
    }

    func updateBankCard(_ bankCard: BankCard, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let userRef = self.db.collection("bank-cards").document(self.userId)
            userRef.collection("cards").whereField("id", isEqualTo: bankCard.id.uuidString).getDocuments { querySnapshot, error in
                if let error = error {
                    print("Ошибка при обновлении банковской карты: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else if let document = querySnapshot?.documents.first {
                    document.reference.updateData([
                        "username": bankCard.name,
                        "backImage": bankCard.backImage,
                        "totalMoney": bankCard.totalMoney,
                        "labelImage": bankCard.labelImage
                    ]) { error in
                        if let error = error {
                            print("Ошибка при обновлении банковской карты: \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                completion(.failure(error))
                            }
                        } else {
                            print("Банковская карта успешно обновлена")
                            DispatchQueue.main.async {
                                completion(.success(true))
                            }
                        }
                    }
                } else {
                    print("Банковская карта не найдена")
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Банковская карта не найдена"])))
                    }
                }
            }
        }
    }
}
