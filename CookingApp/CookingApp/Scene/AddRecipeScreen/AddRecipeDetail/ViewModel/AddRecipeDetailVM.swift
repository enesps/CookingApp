import Combine
import SPIndicator
import Foundation
class AddRecipeDetailVM: ObservableObject {
    @Published var requestModel = AddRecipeModel()
    var onDataUpdate: (() -> Void)?
    private var cancellables: Set<AnyCancellable> = []

    func updateRequestModel(/* gerekli parametreleri belirtin */) {
        
        objectWillChange.send()
    }

    func performTokenAuth(idToken: String) {
        TokenApiService.shared.postRequest(
            idToken: idToken,
            requestModel: requestModel,
            responseType: EmptyResponse.self, // Response olmadığını belirtiyoruz
            endpoint: APIEndpoints.getRecipes,
            baseUrl: APIConstants.baseURL
        )
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch completion {
            case .finished:
                print("Request successful")
                let indicatorView = SPIndicatorView(title: "Yemek eklendi",message: "Yemeginiz Eklendi", preset: .done)
                indicatorView.presentSide = .center
                indicatorView.present(duration: 1)
                // Handle success here if needed
            case .failure(let error):
                // Handle errors here
                print("Error: \(error)")
            }
        }
    receiveValue: { _ in
           print("oldu")
        self.onDataUpdate?()
        }
        .store(in: &cancellables)
    }
}

// EmptyResponse tipi, Combine ile birlikte gelen bir tip. Bu örnekte, response beklenmiyor.
struct EmptyResponse: Decodable {}
