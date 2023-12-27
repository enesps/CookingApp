import Foundation
import Alamofire
import Combine
enum YourServiceError: Error {
    case invalidData
    case networkError
    // Diğer hata durumları ekleyebilirsiniz.
}


class TokenApiService {
    static let shared = TokenApiService()
    
    private let baseURL = "https://reception-witnesses-limit-polls.trycloudflare.com"
    
    func fetchData<T: Decodable>(for endpoint: String, idToken: String) -> AnyPublisher<T, APIError> {
        let url = baseURL + endpoint
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(idToken)"
        ]
        
        return AF.request(url, method: .post, headers: headers)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: T.self)
            .value()
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }
    func tokenSignInPublisher<T: Decodable>(
        idToken: String,
        responseType: T.Type,
        endpoint: String,
        baseUrl: String
    ) -> AnyPublisher<T, YourServiceError> {
        guard let authData = try? JSONEncoder().encode(["idToken": idToken]) else {
            return Fail(error: YourServiceError.invalidData).eraseToAnyPublisher()
        }

        let urlString = baseUrl + endpoint
        guard let url = URL(string: urlString) else {
            return Fail(error: YourServiceError.invalidData).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = authData

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw YourServiceError.networkError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // Handle decoding errors or other errors here
                YourServiceError.networkError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
