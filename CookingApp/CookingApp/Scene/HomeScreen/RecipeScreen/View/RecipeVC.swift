//
//  RecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit

class RecipeVC: UIViewController {
    struct  recipeIngredients{
        var title:String
        var text:String
    }
    var recipeIngredientsArray = [recipeIngredients(title: "Su", text: "1 litre su"), recipeIngredients(title: "Su", text: "1 litre su"),recipeIngredients(title: "Su", text: "1 litre su"),recipeIngredients(title: "Su", text: "1 litre su"),recipeIngredients(title: "Su", text: "1 litre su")]

    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipeName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        let imageView = UIImageView(frame: header.bounds)
        imageView.image = UIImage(named: "chicken") // Fotoğraf adını güncelleyin
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        header.addSubview(imageView)
        recipeTableView.tableHeaderView = header
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RecipeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeIngredientsArray.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeProfileCell", for: indexPath) as! RecipeProfileTableViewCell
            return cell
        }
        else if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! RecipeButtonGroupTableViewCell
            cell.recipeLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.recipeLikeBtn.titleLabel?.text = "3.24"
            cell.recipeShareBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
            cell.recipeShareBtn.titleLabel?.text = "Kaydet"
            return cell
        }

            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeIngredientsCell",for: indexPath) as! RecipeIngredientsTableViewCell
            cell.recipeIngredientsTitle.text = recipeIngredientsArray[indexPath.row-2].title
            cell.recipeIngredientsText.text = recipeIngredientsArray[indexPath.row-2].text
            return cell
            
        


        
        
    }
     func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // Sadece belirli bir satırın yüksekliğini artırın
//        if indexPath.row == 1{
//            return 60.0 // İstediğiniz yükseklik değerini belirtin
//        } else {
//            return 44.0 // Diğer satırlar için varsayılan yükseklik değeri
//        }
//    }
    
    
    
}
