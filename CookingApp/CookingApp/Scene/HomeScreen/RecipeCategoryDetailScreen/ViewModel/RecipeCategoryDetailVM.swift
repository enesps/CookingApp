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

    var data: Model? { get }
    var onDataUpdate: (() -> Void)? { get set }
    func fetchData(for query: String)
}

class RecipeCategoryDetailVM: ViewModelProtocol {
    @Published var data: Recipe?
    var onDataUpdate: (() -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()

    @Published var recipeData: Welcome?
    func fetchData(for query: String) {
        apiService.fetchData(for: query, modelType: Recipe.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
//                switch completion {
////                    case .finished:
////                    print("Yayın tamamlandı.")
////                case .failure(let error):
////                    print("Hata oluştu: \(error)")
//                }
            }, receiveValue: { [weak self] receivedData in
                self?.data = receivedData
                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
        
    }

    func fetchRecipeData(for query: String) {
        apiService.fetchData(for: query, modelType: Welcome.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle completion if needed
            }, receiveValue: { [weak self] receivedData in
                guard let self = self else { return }
                self.recipeData = receivedData
            })
            .store(in: &cancellables)
    }
}
