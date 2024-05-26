import UIKit
import Combine
class InstructionOnBoardingVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var ingredients : [Instruction]?
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = InstructionOnBoardingVM()
    let pages = ["Sayfa 1", "Sayfa 2", "Sayfa 3","","","",""] // Örnek sayfa başlıkları
    // Geçerli sayfa indeksi
    var currentPageIndex : Int = 0
    var ingredientsCount : Int?
    @IBOutlet weak var nextButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false

        view.backgroundColor = .white

        viewModel.onDataUpdate = { [weak self]   in
            print(self?.viewModel.data?.explanation ?? "")
        }
        updateUI()

        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func cancelOnBoarding(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func instructionExplanationAction(_ sender: Any) {
        if let instruction = ingredients?[currentPageIndex].instruction{
            viewModel.fetchData(for: ["instruction" : instruction],endpoint: APIEndpoints.getInstructionDetail)
        }
       
    }
    func updateUI() {
//        navigationItem.title = "\(currentPageIndex)"
        titleLabel.text = ingredients?[currentPageIndex].instruction
        
        // İlk sayfadaysak geri butonunu gizle
        backButton.isHidden = currentPageIndex == 0 
        if currentPageIndex == 0 {
            backButton.isHidden = true
        }else{
            
        }

        // Son sayfadaysak ileri butonunu "Tamam" olarak değiştir
        if currentPageIndex == ingredientsCount! - 1 {
            nextButton.setTitle("Tamam", for: .normal)
        } else {
            nextButton.setTitle("İleri", for: .normal)
        }
    }

    @objc func backButtonTapped() {
        if currentPageIndex > 0 {
            currentPageIndex -= 1
            updateUI()
        }
    }

    @objc func nextButtonTapped() {
        if currentPageIndex < ingredientsCount! - 1 {
            currentPageIndex += 1
            updateUI()
        } else {
            // Onboarding tamamlandı, ana uygulama arayüzüne geçiş yapılabilir
            // Örneğin, UserDefaults kullanarak tamamlanma durumunu işaretle
            // ve uygun şekilde ana uygulama arayüzüne geçiş yapabilirsiniz.
            // Burada sadece çıkış yaparak işlemi sonlandırıyoruz.
            dismiss(animated: true, completion: nil)
        }
    }

    func animateTransition() {
        UIView.transition(with: titleLabel, duration: 0.8, options: .transitionCrossDissolve, animations: {
            self.updateUI()
        }, completion: nil)
    }
}
