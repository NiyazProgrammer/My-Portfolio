import Foundation

enum TransactionCategory: Hashable, Codable {
    case expense(TransactionExpenseCategory)
    case income(TransactionIncomeCategory)

    var rawValue: String {
           switch self {
           case .expense(let category):
               return category.rawValue
           case .income(let category):
               return category.rawValue
           }
       }
}

enum TransactionExpenseCategory: String, CaseIterable, Codable {
        case food = "Еда"
        case housing = "Жилье"
        case education = "Образование"
        case transport = "Транспорт"
        case bank = "Банк"
        case career = "Карьера"
        case charity = "Благотворительность"
        case subscriptions = "Подписки"
        case health = "Здоровье"
        case clothing = "Одежда"
        case holidays = "Праздники"
        case technique = "Техника"
        case car = "Автомобиль"
        case business = "Бизнес"
        case flowers = "Цветы"
        case children = "Дети"
        case house = "Дом"
        case selfCare = "Самоуход"
        case services = "Услуги"
        case entertaiment = "Развлечения"
        case travel = "Путешествия"
        case goalsAndDesires = "Цели и желания"
        case others = "Другое"
}


enum TransactionIncomeCategory: String, CaseIterable, Codable {
    case business = "Бизнес"
    case salary = "Зарплата"
    case topUp = "Пополнения"
    case bonus = "Премия"
    case gifts = "Подарки"
    case pension = "Пенсия"
}
