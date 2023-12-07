//
//  RecipeCategoryDetailVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 8.12.2023.
//

import Foundation
import Combine
class RecipeCategoryDetailVM: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()

    @Published var recipeData: Welcome?

    func fetchRecipeData(for query: String) {
        apiService.fetchData(for: query, modelType: Welcome.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle completion if needed
            }, receiveValue: { [weak self] receivedData in
                self?.recipeData = receivedData
            })
            .store(in: &cancellables)
    }
}
