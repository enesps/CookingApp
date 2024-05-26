//
//  InstructionOnBoardingVM.swift
//  YapYe
//
//  Created by Enes Pusa on 24.05.2024.
//

import Foundation
import Combine
class InstructionOnBoardingVM : ViewModelProtocol{

    
    @Published var data: InstructionExplanation?
    var onDataUpdate: (() -> Void)?
    
    var onSkeletonUpdate: ((Bool) -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()
    private var isSkeletonActive: Bool = false
    func fetchData(for query: [String : String], endpoint: String) {
        apiService.fetchData(for: query, modelType: InstructionExplanation.self, baseURL: APIConstants.baseURL, endpoint: endpoint)
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
    
    func explainInstruction(for query: [String: String] = [:], endpoint: String){

    }
}
