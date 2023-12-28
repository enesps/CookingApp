//
//  RecipeViewModel.swift
//  CookingApp
//
//  Created by Enes Pusa on 14.12.2023.
//

import Foundation
import Combine
class RecipeViewModel : ViewModelProtocol{

    @Published var data: Recipe?
    var onDataUpdate: (() -> Void)?
    
    var onSkeletonUpdate: ((Bool) -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()
    private var isSkeletonActive: Bool = false

    
    func fetchData(for query: [String: String] = [:], endpoint: String) {
        onSkeletonUpdate?(true)
        apiService.fetchData(for: query, modelType: Recipe.self, baseURL: APIConstants.baseURL, endpoint: endpoint)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                    
                case .finished:
                    self.onSkeletonUpdate?(false)
                    break
                case .failure(let error):
                    // Hata durumu ile ilgili işlemleri burada yapabilirsiniz.
                    print("Hata oluştu: \(error)")
                }
            }, receiveValue: { [weak self] receivedData in
                self?.data = receivedData
                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
        
    }
    
    
}
