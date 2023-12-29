
import Foundation
import Combine
import Alamofire
import UIKit
import SPIndicator
class RecipeHomeVM : ViewModelProtocol{
    
    @Published var data: Recipe?
    var onDataUpdate: (() -> Void)?
    
    var onSkeletonUpdate: ((Bool) -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    private let apiService = APIService()
    private var isSkeletonActive: Bool = false
    
    
    func fetchData(for query: [String: String] = [:], endpoint: String) {
        
        onSkeletonUpdate?(true)
        let reachabilityManager = NetworkReachabilityManager()
        if reachabilityManager?.isReachable ?? false {
            apiService.fetchData(for: query, modelType: Recipe.self, baseURL: APIConstants.baseURL, endpoint: endpoint)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    
                    switch completion {
                        
                    case .finished:
                        self.onSkeletonUpdate?(false)
                        break
                    case .failure(let error):
                        // Hata durumu ile ilgili işlemleri burada yapabilirsiniz.
                        print("Hata oluştu: \(error.localizedDescription)")
//                        let indicatorView = SPIndicatorView(title: "Beklenmeyen Bir hata olustu.",message: error.localizedDescription, preset: .error)
//                        indicatorView.presentSide = .bottom
//                        indicatorView.present(duration: 2)
                    }
                }, receiveValue: { [weak self] receivedData in
                    self?.data = receivedData
                    self?.onDataUpdate?()
                })
                .store(in: &cancellables)
        } else {
            // İnternet bağlantısı yoksa
            onSkeletonUpdate?(false)
            print("İnternet bağlantısı yok")
            let indicatorView = SPIndicatorView(title: "Beklenmeyen Bir Hata Olustu.",message: "İnternet bağlantısı yok", preset: .error)
            indicatorView.presentSide = .bottom
            indicatorView.present(duration: 2)
            
        }
    }
    
    
}
