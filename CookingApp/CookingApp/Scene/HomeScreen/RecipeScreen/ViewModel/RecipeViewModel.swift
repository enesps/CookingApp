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
    @Published var statusCode:Int?
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
    func fetchData1(for query: [String: String] = [:], endpoint: String,idToken: String){
        onSkeletonUpdate?(true)
        apiService.tokenAuthPublisher(idToken: idToken, responseType: Recipe.self, endpoint: endpoint, baseUrl: APIConstants.baseURL)
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
            }, receiveValue: { [weak self] (receivedData, statusCode) in
                self?.data = receivedData
                print("Status code: \(statusCode)")
                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
    }
    func addLike(for query: [String: String] = [:], endpoint: String, idToken: String) {
        
        apiService.saveService(idToken: idToken, endpoint: endpoint, baseUrl: APIConstants.baseURL, query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    
                switch completion {
                case .finished: break
                   
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            }, receiveValue: { statusCode in
                self.statusCode = statusCode
            })
            .store(in: &cancellables)
    }

    
    
}
