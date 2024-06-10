import Foundation
import Alamofire

class CurrencyNetworkingManager {
    private let jsonDecoder: JSONDecoder

    init() {
        self.jsonDecoder = JSONDecoder()
    }

    func obtainCoins(completion: @escaping (Result<Coin, Error>) -> Void) {
        let url = "https://www.cbr-xml-daily.ru/daily_json.js"

        AF.request(url, method: .get).validate().responseDecodable(of: Coin.self, decoder: jsonDecoder) { response in
            switch response.result {
            case .success(let coin):
                completion(.success(coin))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
