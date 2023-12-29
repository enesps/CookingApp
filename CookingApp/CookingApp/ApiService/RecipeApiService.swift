import Foundation
import Combine
import Security
enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
    case jsonParsingFailure
    case unauthorized
    case notFound
    case serverError
    case badRequest
    case forbidden
    case internalServerError
    // Diğer hata durumları eklenebilir.

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .requestFailed:
            return "İstek başarısız oldu"
        case .invalidResponse:
            return "Geçersiz yanıt"
        case .invalidData:
            return "Geçersiz veri"
        case .jsonParsingFailure:
            return "JSON ayrıştırma hatası"
        case .unauthorized:
            return "Yetkisiz erişim"
        case .notFound:
            return "Bulunamadı"
        case .serverError:
            return "Sunucu hatası"
        case .badRequest:
            return "Geçersiz istek"
        case .forbidden:
            return "Yasaklandı"
        case .internalServerError:
            return "İç sunucu hatası"
        // Diğer hata durumlarına uygun açıklamaları ekleyebilirsiniz.
        }
    }
}

class APIService {
    func fetchData<T: Decodable>(for query: [String: String] = [:], modelType: T.Type, baseURL: String, endpoint: String) -> AnyPublisher<T, APIError> {
        guard let url = makeURL(for: endpoint, baseURL: baseURL, parameters: query) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse {
                        throw self.mapHTTPStatusCodeToAPIError(statusCode: httpResponse.statusCode)
                    } else {
                        throw APIError.requestFailed
                    }
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in APIError.requestFailed}
            .eraseToAnyPublisher()
    }
    
    private func makeURL(for endpoint: String, baseURL: String, parameters: [String: String]?) -> URL? {
        var urlComponents = URLComponents(string: baseURL + endpoint)
        
        if let parameters = parameters, !parameters.isEmpty {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return urlComponents?.url
    }
    private func mapHTTPStatusCodeToAPIError(statusCode: Int) -> APIError {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500:
            return .internalServerError
        default:
            return .requestFailed
        }
        
    }
}
