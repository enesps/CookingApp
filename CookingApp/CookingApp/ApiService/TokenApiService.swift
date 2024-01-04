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
    func tokenAuthPublisher<T: Decodable>(
        idToken: String,
        responseType: T.Type,
        endpoint: String,
        baseUrl: String
    ) -> AnyPublisher<T, YourServiceError> {
        let urlString = baseUrl + endpoint
        guard var urlComponents = URLComponents(string: urlString) else {
            return Fail(error: YourServiceError.invalidData).eraseToAnyPublisher()
        }

        // Query parameters can be added if needed
        urlComponents.queryItems = [
            URLQueryItem(name: "idToken", value: idToken)
            // Add other query parameters as needed
        ]

        guard let url = urlComponents.url else {
            return Fail(error: YourServiceError.invalidData).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")

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
    func postRequest<T: Encodable, R: Decodable>(
        idToken: String,
        requestModel: T,
        responseType: R.Type,
        endpoint: String,
        baseUrl: String
    ) -> AnyPublisher<R, YourServiceError> {
        let urlString = baseUrl + endpoint
        guard let url = URL(string: urlString) else {
            return Fail(error: YourServiceError.invalidData).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")

        do {
            // Encode the request model to JSON data and set it as the HTTP body
            request.httpBody = try JSONEncoder().encode(requestModel)
        } catch {
            return Fail(error: YourServiceError.invalidData).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw YourServiceError.networkError
                }
                return data
            }
            .decode(type: R.self, decoder: JSONDecoder())
            .mapError { error in
                // Handle decoding errors or other errors here
                YourServiceError.networkError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
