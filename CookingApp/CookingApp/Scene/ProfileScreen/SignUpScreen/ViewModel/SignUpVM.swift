//
//  SignUpVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 25.12.2023.
//

import Foundation
import Combine
class SignUpVM {

    private let apiService = TokenApiService()
    private var cancellables: Set<AnyCancellable> = []
    var onDataUpdate: ((SignUpModel?, YourServiceError?) -> Void)?
    @Published var data: SignUpModel? = nil
    @Published var error: YourServiceError? = nil
    
    func signInWithToken(idToken: String) {
        
        apiService.tokenSignInPublisher(idToken: idToken, responseType: SignUpModel.self, endpoint: APIEndpoints.getGoogleLogin, baseUrl: APIConstants.baseURL)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                    
                }
            } receiveValue: { yourModel in
                
                    self.data = yourModel
                    // Call the onDataUpdate closure when there is a new data
                    self.onDataUpdate?(yourModel, nil)
                
            }
            .store(in: &cancellables)
    }

//    func tokenSignIn(idToken: String) -> AnyPublisher<Void, APIError> {
//        let endpoint = "/tokensignin"
//        
//        let query: [String: String] = ["idToken": idToken]
//        
//        return apiService.fetchData(for: query, modelType: Recipe.self, baseURL: APIConstants.baseURL, endpoint: endpoint)
//            .map { _ in }
//            .eraseToAnyPublisher()
//    }
}
