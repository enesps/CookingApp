//
//  RecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit
enum CellType {
    case recipeHeaderTableViewCell
    case recipeIngredientsTableViewCell
    case recipeCookingTableViewCell
}
class RecipeVC: UIViewController {
    struct  recipeIngredients{
        var title:String
        var text:String
    }
    struct cellData{
        var sectionType:CellType
        var data:[Any]
    }

    let cellTypes: [CellType] = [.recipeHeaderTableViewCell, .recipeIngredientsTableViewCell, .recipeCookingTableViewCell]
    
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
             cellData(sectionType: .recipeIngredientsTableViewCell, data: recipeIngredientsArray),
             cellData(sectionType: .recipeCookingTableViewCell, data: array)
                                             
        ]
    }
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipeName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.register(UINib(nibName: "RecipeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeHeaderTableViewCell")
        recipeTableView.register(UINib(nibName: "RecipeCookingTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCookingTableViewCell")
        recipeTableView.register(UINib(nibName: "RecipeIngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeIngredientsTableViewCell")

        recipeTableView.separatorStyle = .none
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        let imageView = UIImageView(frame: header.bounds)
        imageView.image = UIImage(named: "chicken") // Fotoğraf adını güncelleyin
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        header.addSubview(imageView)
        recipeTableView.tableHeaderView = header
    }
    


}
extension RecipeVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataArray.count
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellDataArray[indexPath.section].sectionType
        switch cellType {
        case .recipeHeaderTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeHeaderTableViewCell", for: indexPath) as! RecipeHeaderTableViewCell
            cell.recipeLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.recipeLikeBtn.titleLabel?.text = "3.24"
            cell.recipeShareBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
            cell.recipeShareBtn.titleLabel?.text = "Kaydet"
            return cell
        case .recipeIngredientsTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsTableViewCell", for: indexPath) as! RecipeIngredientsTableViewCell
            if let ingredientsData = cellDataArray[indexPath.section].data[indexPath.row] as? recipeIngredients {
                    // ingredientsData'yi kullanarak hücre içeriğini ayarla
                
                    cell.recipeIngredientsTitle.text = "\(ingredientsData.title):"
                cell.recipeIngredientsText.text = ingredientsData.text
                }
            return cell
            
        case .recipeCookingTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCookingTableViewCell", for: indexPath) as! RecipeCookingTableViewCell
        
                      // cookingData'yi kullanarak hücre içeriğini ayarla
                      
            cell.recipeStepNumber.text = "\(indexPath.row+1)/\(cellDataArray[indexPath.section].data.count)"
            cell.recipeStepCooking.text = (cellDataArray[indexPath.section].data[indexPath.row] as? String)
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
        let section = cellDataArray[section].sectionType
        switch section{
            
       
        case .recipeIngredientsTableViewCell:
            return "Malzemeler:"
        case .recipeCookingTableViewCell:
            return "Nasil Yapilir?"
        default:
            return nil
        }
    
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        // Başlık fontunu ayarlayın
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 18) // İstediğiniz boyutu kullanabilirsiniz
    }

    
    
    
    
}
