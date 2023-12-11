//
//  RecipeCategoryDetailVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 8.12.2023.
//

import Foundation
import Combine
protocol ViewModelProtocol: ObservableObject {
    associatedtype Model
    
    var data: [Model] { get }
    var onDataUpdate: (() -> Void)? { get set }
    func fetchData(for query: [String: String])
}
    

class RecipeCategoryDetailVM: ViewModelProtocol {
    @Published var data: [Recipe] = []
    var filteredData: [Recipe] = []
    var onDataUpdate: (() -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()
    var endpoint = "/v1/recipes/category/"

    @Published var recipeData: Welcome?
    func fetchData(for query: [String: String] = [:]) {
        apiService.fetchData(for: query, modelType: [Recipe].self, baseURL: "https://norton-simulation-pop-compounds.trycloudflare.com", endpoint: self.endpoint)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Hata durumu ile ilgili işlemleri burada yapabilirsiniz.
                    print("Hata oluştu: \(error)")
                }
            }, receiveValue: { [weak self] receivedData in
                self?.data = receivedData
                self?.filteredData = receivedData
                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
        
    }

//    func fetchRecipeData(for query: String) {
//        apiService.fetchData(for: query, modelType: Welcome.self)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                // Handle completion if needed
//            }, receiveValue: { [weak self] receivedData in
//                guard let self = self else { return }
//                self.recipeData = receivedData
//            })
//            .store(in: &cancellables)
//    }
}
