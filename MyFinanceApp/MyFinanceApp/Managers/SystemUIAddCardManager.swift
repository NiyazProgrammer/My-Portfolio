import Foundation

class SystemUIAddCardManager {
    private var backgrounds = ["background1", "background2", "background3", "background4", "background5", "background6"]

    private var bankIcons: [String] = [
        "alpha", "tinkoff", "sber", "rayfazen", "open", "uMoney"
    ]

    private var currencies = ["Российский рубль"]

    func getCurrency() -> [String] {
        return currencies
    }

    func getIcons() -> [String] {
        return bankIcons
    }

    func getBackgrounds() -> [String] {
        return backgrounds
    }
}
