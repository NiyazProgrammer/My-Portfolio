import Foundation
import Combine

class MainViewModel {
    let users: [User]
    @Published var likeTap: Bool = false
    private var currentUserIndex: Int = 1
    @Published var cards: [CardUser] = []

    init(users: [User]) {
        self.users = users

        for index in 0..<2 {
            cards.append(CardUser(with: users[index]))
        }
    }

    func EnumbledUser(isLikeUser: Bool) {
        likeTap = isLikeUser
    }

    func ChangeCurrentUserIndex(for number: Int) {
        currentUserIndex += number
    }

    func moveCard() {
        cards.removeFirst()
        currentUserIndex += 1
        let user = users[currentUserIndex % users.count]
        cards.append(CardUser(with: user))
    }
    
    func backMoveCard(firstCardUser: CardUser, secondCardUser: CardUser) {
        cards.removeAll()
        cards.append(firstCardUser)
        cards.append(secondCardUser)
        currentUserIndex -= 1
    }
}
