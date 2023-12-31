//
//  RecipeLikeVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 31.12.2023.
//

import Foundation
import Combine
import SPIndicator
class RecipeLikeVM {
    private let apiService = TokenApiService()
    private var cancellables: Set<AnyCancellable> = []
    var onDataUpdate: (([Recipe]?, YourServiceError?) -> Void)?
    @Published var data: [Recipe]? = nil
    @Published var error: YourServiceError? = nil
    func fetchData(idToken: String) {
        
        apiService.tokenAuthPublisher(idToken: idToken, responseType: [Recipe].self, endpoint: APIEndpoints.recipeLikeList, baseUrl: APIConstants.baseURL)
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
