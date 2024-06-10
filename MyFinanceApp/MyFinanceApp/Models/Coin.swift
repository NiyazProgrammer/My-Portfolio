import Foundation

struct Coin: Codable {
    let date: String?
    let previousDate: String?
    let previousURL: String?
    let timestamp: String?
    let valute: [String: Valute]?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}
