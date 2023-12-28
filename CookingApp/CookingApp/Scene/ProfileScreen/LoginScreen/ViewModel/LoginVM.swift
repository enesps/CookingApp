//
//  LoginVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.12.2023.
//

import Foundation
import Combine
class LoginVM {
    @Published var username: String = ""
    @Published var password: String = ""
    private let apiService = TokenApiService()
    private var cancellables: Set<AnyCancellable> = []
    var onDataUpdate: ((SignUpModel?, YourServiceError?) -> Void)?
    @Published var data: SignUpModel? = nil
    @Published var error: YourServiceError? = nil
    var isLoginButtonEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($username, $password)
            .map { username, password in
                return !username.isEmpty && !password.isEmpty && password.count >= 1
            }
            .eraseToAnyPublisher()
    }

    
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
}
