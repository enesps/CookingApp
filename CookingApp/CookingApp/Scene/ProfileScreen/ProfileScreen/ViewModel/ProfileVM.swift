//
//  ProfileVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.12.2023.
//

import Foundation
import Combine
import SPIndicator
class ProfileVM{
    
    private let apiService = TokenApiService()
    private var cancellables: Set<AnyCancellable> = []
    var onDataUpdate: ((ProfileModel?, YourServiceError?) -> Void)?
    @Published var data: ProfileModel? = nil
    @Published var error: YourServiceError? = nil
    func signInWithToken(idToken: String) {
        
        apiService.tokenAuthPublisher(idToken: idToken, responseType: ProfileModel.self, endpoint: APIEndpoints.getProfile, baseUrl: APIConstants.baseURL)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    let indicatorView = SPIndicatorView(title: "Profil",message: "Profile Erişim Sağlandı", preset: .done)
                    indicatorView.presentSide = .center
                    indicatorView.present(duration: 1)
                    break
                case .failure(let error):
                    self.error = error
                    let indicatorView = SPIndicatorView(title: "Profil",message: "Profile Erişim Sağlanamadı", preset: .error)
                    indicatorView.presentSide = .bottom
                    indicatorView.present(duration: 3)
                }
            } receiveValue: { yourModel in
                
                self.data = yourModel
                // Call the onDataUpdate closure when there is a new data
                self.onDataUpdate?(yourModel, nil)
                
            }
            .store(in: &cancellables)
    }
}
