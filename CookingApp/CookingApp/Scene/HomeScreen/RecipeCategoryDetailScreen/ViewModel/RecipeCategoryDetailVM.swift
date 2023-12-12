//
//  RecipeCategoryDetailVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 8.12.2023.
//

import Foundation
import Combine
import SkeletonView

protocol ViewModelProtocol: ObservableObject {
    associatedtype Model
    
    var data: [Model] { get }
    var onDataUpdate: (() -> Void)? { get set }
    func fetchData(for query: [String: String], endpoint: String)
}


class RecipeCategoryDetailVM: ViewModelProtocol {

    @Published var data: [Recipe] = []
    var filteredData: [Recipe] = []
    var onDataUpdate: (() -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()
    @Published var recipeData: Welcome?
 
    func fetchData(for query: [String: String] = [:], endpoint: String) {
//        onSkeletonUpdate?(true)
        apiService.fetchData(for: query, modelType: [Recipe].self, baseURL: APIConstants.baseURL, endpoint: endpoint)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
//                self.onSkeletonUpdate?(false)
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

    func fetchData1(for query: [String: String] = [:], endpoint: String) {
        apiService.fetchData(for: query, modelType: Recipe.self, baseURL: APIConstants.baseURL, endpoint: endpoint)
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
                self?.data[(self?.data.count)!] = receivedData
                self?.filteredData[(self?.filteredData.count)!] = receivedData
                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
        
    }
    func convertTurkishToEnglish(_ inputString: String) -> String {
        let turkishCharacters = ["ı", "ğ", "ü", "ş", "i", "ö", "ç", "Ğ", "Ü", "Ş", "İ", "Ö", "Ç"]
        let englishReplacements = ["i", "g", "u", "s", "i", "o", "c", "G", "U", "S", "I", "O", "C"]

        var convertedString = inputString

        for (index, turkishChar) in turkishCharacters.enumerated() {
            let englishReplacement = englishReplacements[index]
            convertedString = convertedString.replacingOccurrences(of: turkishChar, with: englishReplacement)
        }

        return convertedString
    }
     func manipulateString(_ inputString: String) -> String {
        var manipulatedString = inputString.lowercased()

        if manipulatedString.count >= 3 {
            let indexToTrim = manipulatedString.index(manipulatedString.endIndex, offsetBy: -3)
            manipulatedString = String(manipulatedString[..<indexToTrim])
        }
        
        manipulatedString = manipulatedString.replacingOccurrences(of: " ", with: "-")
        
        return manipulatedString
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