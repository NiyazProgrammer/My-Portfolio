import Foundation

struct Coin: Codable {
    let Date: String
    let PreviousDate: String
    let PreviousURL: String
    let Timestamp: String
    let Valute: [String: Valute]
}
struct Valute: Codable {
    let ID: String
    let NumCode: String
    let CharCode: String
    let Nominal: Int
    let Name: String
    let Value: Double
    let Previous: Double
}
/*
 {
 {
     "Date": "2024-02-07T11:30:00+03:00",
     "PreviousDate": "2024-02-06T11:30:00+03:00",
     "PreviousURL": "\/\/www.cbr-xml-daily.ru\/archive\/2024\/02\/06\/daily_json.js",
     "Timestamp": "2024-02-06T20:00:00+03:00",
     "Valute": {
         "AUD": {
             "ID": "R01010",
             "NumCode": "036",
             "CharCode": "AUD",
             "Nominal": 1,
             "Name": "Австралийский доллар",
             "Value": 59.0808,
             "Previous": 59.3812
         },
         "VND": {
             "ID": "R01150",
             "NumCode": "704",
             "CharCode": "VND",
             "Nominal": 10000,
             "Name": "Вьетнамских донгов",
             "Value": 37.8418,
             "Previous": 38.0911
         },
         "AED": {
             "ID": "R01230",
             "NumCode": "784",
             "CharCode": "AED",
             "Nominal": 1,
             "Name": "Дирхам ОАЭ",
             "Value": 24.6928,
             "Previous": 24.845
         },
         "USD": {
             "ID": "R01235",
             "NumCode": "840",
             "CharCode": "USD",
             "Nominal": 1,
             "Name": "Доллар США",
             "Value": 90.6842,
             "Previous": 91.2434
         },
         "EUR": {
             "ID": "R01239",
             "NumCode": "978",
             "CharCode": "EUR",
             "Nominal": 1,
             "Name": "Евро",
             "Value": 97.444,
             "Previous": 98.2279
         }
     }
 }

 */

class NetWorkingManager {
    private let session: URLSession

    lazy var jsonDecoder: JSONDecoder = {
       JSONDecoder()
    }()

    init(with configuration: URLSessionConfiguration) {
       // delegate нужен для реагирования на запросы
       // URLSessionConfiguration описывает то как сессия будет себя ввести
       session = URLSession(configuration: configuration)
    }

    func obtainCoins() async throws -> Coin? {
       guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else { return nil }

       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "GET"

        let responseData = try await session.data(for: urlRequest)

        var coin = try jsonDecoder.decode(Coin.self, from: responseData.0)
        
        return coin
    }

    
    func obtainCountryKeys(with valute: [String: Valute]) -> [String] {
        var charCodes = valute.map { $0.value.CharCode }
        return charCodes
    }
}
