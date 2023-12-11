import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case requestFailed
    // Diğer hata durumları eklenebilir.
}

class APIService {
    func fetchData<T: Decodable>(for query: [String: String] = [:], modelType: T.Type, baseURL: String, endpoint: String) -> AnyPublisher<T, APIError> {
        guard let url = makeURL(for: endpoint, baseURL: baseURL, parameters: query) else {
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
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }

    private func makeURL(for endpoint: String, baseURL: String, parameters: [String: String]?) -> URL? {
        var urlComponents = URLComponents(string: baseURL + endpoint)

        if let parameters = parameters, !parameters.isEmpty {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return urlComponents?.url
    }

    
}
