import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case requestFailed
    // Diğer hata durumları eklenebilir.
}

class APIService {
    func fetchData<T: Decodable>(for query: String, modelType: T.Type) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: "https://api.agify.io?name=\(query)") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.requestFailed
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                APIError.requestFailed
                // Diğer hata durumlarına göre map işlemi yapılabilir.
            }
            .eraseToAnyPublisher()
    }
}
