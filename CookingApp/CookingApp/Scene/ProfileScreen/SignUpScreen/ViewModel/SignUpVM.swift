//
//  SignUpVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 25.12.2023.
//

import Foundation
import Combine
class SignUpVM {
    private let apiService = APIService()
    func tokenSignIn(idToken: String) -> AnyPublisher<Void, APIError> {
        let endpoint = "/tokensignin"
        
        let query: [String: String] = ["idToken": idToken]
        
        return apiService.fetchData(for: query, modelType: Recipe.self, baseURL: APIConstants.baseURL, endpoint: endpoint)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
