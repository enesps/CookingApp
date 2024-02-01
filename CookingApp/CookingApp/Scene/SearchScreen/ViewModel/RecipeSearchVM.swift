//
//  RecipeSearchVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 21.12.2023.
//
import Combine
import Foundation
import SPIndicator
class RecipeSearchVM: ViewModelProtocol {
    @Published var data: [Recipe]? = []
    var filteredData: [Recipe] = []
    var onDataUpdate: (() -> Void)?
    var onSkeletonUpdate: ((Bool) -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()
    private var isSkeletonActive: Bool = false
    func fetchData(for query: [String: String] = [:], endpoint: String) {
        onSkeletonUpdate?(true)
        apiService.fetchData(for: query, modelType: [Recipe].self, baseURL: APIConstants.baseURL, endpoint: endpoint)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.onSkeletonUpdate?(false)
                    break
                case .failure(let error):

                    print("Hata oluştu: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] receivedData in
                self?.data = receivedData
                self?.filteredData = receivedData
                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
        }
    func fetchDataSearch(for query: [String: String] = [:], endpoint: String) {
        self.onSkeletonUpdate?(true)
        apiService.fetchData(for: query, modelType: [Recipe].self, baseURL: APIConstants.baseURL, endpoint: endpoint)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.onSkeletonUpdate?(false)
                    break
                case .failure(let error):
                    
                    self.onSkeletonUpdate?(false)
                    let indicatorView = SPIndicatorView(title: "Arama Sonucu",message: "Islem Tamamlanilamadi" , preset: .error)
                    indicatorView.presentSide = .center
                    indicatorView.present(duration: 2)
                
                }
            }, receiveValue: { [weak self] receivedData in
                for i in receivedData{
                    self?.data?.append(i)
                    self?.filteredData.append(i)
                }

                self?.onDataUpdate?()
            })
            .store(in: &cancellables)
        }
}
