//
//  RecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit
import Combine
import Kingfisher
enum CellType {
    case recipeHeaderTableViewCell
    case recipeTime
    case recipeIngredientsTableViewCell
    case recipeCookingTableViewCell
//    case recipePickerPeopleTableViewCell
}
class RecipeVC: UIViewController {
    struct  recipeIngredients{
        var title:String
        var text:String
    }
    
    struct recipeTimer{
        var  cookingTime, preparationTime, servesFor: String?
    }
    struct cellData{
        var sectionType:CellType
        var data:[Any]
    }

    let cellTypes: [CellType] = [.recipeHeaderTableViewCell,
                                 .recipeTime, .recipeIngredientsTableViewCell, .recipeCookingTableViewCell/*.recipePickerPeopleTableViewCell*/]
    
    var recipeIngredientsArray = [recipeIngredients(title: "zeytinyağı", text: "2 yemek kaşığı"), recipeIngredients(title: "soğan", text: "2 adet"),
        recipeIngredients(title: "pirinç", text: "2 su bardağı"),
        recipeIngredients(title: "sıcak su", text: "2 su bardağı"),
        recipeIngredients(title: "kuş üzümü", text: "1,5 yemek kaşığı ")]
 var array = ["Pirinçleri sıcak ve tuzlu suda 15-20 dakika bekletin.",
              "Kuş üzümlerini sıcak suda bekletin ve şişmelerini sağlayın.",
              "Soğanları ince ince doğrayın.",
              "Tencereyi ısıtın ve zeytinyağını ekleyin.",
              "Soğanları karıştıra karıştıra kavurun.",
              "Suyunu süzüp duruladığınız pirinçleri ekleyin ve sıcak suyu ekleyip baharatları ve kuş üzümünü ilave edin. Kısık ateşte 15 dakika demlemeye bırakın.",
              "Demlenen iç harcı soğumaya bırakın."]
    
    var cellDataArray: [cellData] {
        return [
             cellData(sectionType: .recipeHeaderTableViewCell, data: ["kjnsks"]),
//             cellData(sectionType: .recipePickerPeopleTableViewCell, data: ["csdsdc"]),
             cellData(sectionType: .recipeIngredientsTableViewCell, data: recipeIngredientsArray),

             cellData(sectionType: .recipeCookingTableViewCell, data: array)
                                             
        ]
    }
    @IBOutlet weak var recipeTableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = RecipeViewModel()
    var celldataArray  = [cellData]()
    var recipeId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        tableViewConfigure()
        dataUpdate()
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipeById)\(recipeId ?? -1)")
    }
    func skeletonUpdate(){
        viewModel.onSkeletonUpdate = { [weak self] isActive in
            if isActive {
                self?.recipeTableView.isSkeletonable = true
        //        recipeCollectionView.showAnimatedSkeleton(usingColor: .lightGray, animation: animation, transition: .crossDissolve(0.25))
                self?.recipeTableView.showAnimatedGradientSkeleton()
            } else {
                self?.recipeTableView.stopSkeletonAnimation()
                self?.view.hideSkeleton()
            }
        }
    }
    func headerOfTableView(){
        recipeTableView.separatorStyle = .none
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size.width))
        let imageView = UIImageView(frame: header.bounds)

        if let url = URL(string: (viewModel.data?.imageURL!)!) {
            imageView.kf.setImage(with: url)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        header.addSubview(imageView)
        recipeTableView.tableHeaderView = header
    }
    func dataUpdate(){
        viewModel.onDataUpdate = { [weak self]   in
            self?.celldataArray.append(cellData(sectionType: .recipeHeaderTableViewCell, data: ["kjnsks"]))
            self?.celldataArray.append(cellData(sectionType: .recipeTime, data: [recipeTimer(cookingTime: self?.viewModel.data?.cookingTime, preparationTime: self?.viewModel.data?.preparationTime,servesFor: self?.viewModel.data?.servesFor)]))
            self?.celldataArray.append(cellData(sectionType: .recipeIngredientsTableViewCell, data: (self?.viewModel.data?.ingredients)!))
            self?.celldataArray.append(cellData(sectionType: .recipeCookingTableViewCell, data: (self?.viewModel.data?.instructions)!))
            self?.headerOfTableView()
            self?.recipeTableView.reloadData()

        }
    }
    func tableViewConfigure(){
        
        recipeTableView.delegate = self
         recipeTableView.dataSource = self
         recipeTableView.register(UINib(nibName: "RecipeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeHeaderTableViewCell")
         recipeTableView.register(UINib(nibName: "RecipeCookingTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCookingTableViewCell")
         recipeTableView.register(UINib(nibName: "RecipeIngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeIngredientsTableViewCell")
         recipeTableView.register(UINib(nibName: "RecipePickerPeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipePickerPeopleTableViewCell")
        recipeTableView.register(UINib(nibName: "RecipeCookingInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCookingInfoTableViewCell")
    }


}
extension RecipeVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return celldataArray.count
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celldataArray[section].data.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = celldataArray[indexPath.section].sectionType
        switch cellType {
        case .recipeHeaderTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeHeaderTableViewCell", for: indexPath) as! RecipeHeaderTableViewCell
            cell.recipeLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.recipeLikeBtn.titleLabel?.text = "3.24"
            cell.recipeShareBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
            cell.recipeShareBtn.titleLabel?.text = "Kaydet"
            return cell
//        case .recipePickerPeopleTableViewCell:
//            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipePickerPeopleTableViewCell", for: indexPath) as! RecipePickerPeopleTableViewCell
//            return cell
        case .recipeIngredientsTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsTableViewCell", for: indexPath) as! RecipeIngredientsTableViewCell
            if let ingredientsData = celldataArray[indexPath.section].data[indexPath.row] as? recipeIngredients {
                    // ingredientsData'yi kullanarak hücre içeriğini ayarla
                
                    cell.recipeIngredientsTitle.text = "\(ingredientsData.title):"
                cell.recipeIngredientsText.text = ingredientsData.text
                }
            return cell
            
        case .recipeCookingTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCookingTableViewCell", for: indexPath) as! RecipeCookingTableViewCell
        
                      // cookingData'yi kullanarak hücre içeriğini ayarla
                      
            cell.recipeStepNumber.text = "\(indexPath.row+1)/\(celldataArray[indexPath.section].data.count)"
            cell.recipeStepCooking.text = (celldataArray[indexPath.section].data[indexPath.row] as? String)
                return cell
                  

        
            
        case .recipeTime:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCookingInfoTableViewCell", for: indexPath) as! RecipeCookingInfoTableViewCell
            if let recipeTime = celldataArray[indexPath.section].data[indexPath.row] as? recipeTimer {
                cell.servesFor.text = recipeTime.servesFor
                cell.cookingTime.text = recipeTime.cookingTime
                cell.preparationTime.text = recipeTime.preparationTime
            }
            return cell
            
        }

    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return 120 // İlk section'daki hücre yüksekliği
//        case 1:
//            return 120
//        case 2:
//            return 120// İkinci section'daki hücre yüksekliği
//        default:
//            return UITableView.automaticDimension
//        }
//    }
//    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
//        return 393
//    }
     func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = celldataArray[section].sectionType
        switch section{
            
       
        case .recipeIngredientsTableViewCell:
            return "Malzemeler:"
//        case .recipePickerPeopleTableViewCell:
//            return "Kac Kisilik?"
        case .recipeHeaderTableViewCell:
            
            return viewModel.data?.recipeName
        case .recipeCookingTableViewCell:
            return "Nasil Yapilir?"

        case .recipeTime:
            return ""
            
        }
    
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        // Başlık fontunu ayarlayın
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
    }

    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        recipeTableView.separatorStyle = .none
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width-93))
//        let imageView = UIImageView(frame: header.bounds)
//        print(viewModel.data?.imageURL)
//        if let url = URL(string: (viewModel.data?.imageURL!)!) {
//            imageView.kf.setImage(with: url)
//        }
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        header.addSubview(imageView)
//        
//        return header
//    }
    
    
}
