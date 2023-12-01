//
//  RecipeSavedVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit

class RecipeSavedVC: UIViewController {
    struct recipeSavedData{
        var recipeImage : String
        var recipeName : String
        var recipeScore : String
        var recipeCookingTime : String
        var recipeDifficultyLevel : String
    }
    var data = [recipeSavedData(recipeImage: "chicken", recipeName: "Tavuk", recipeScore: "4.5", recipeCookingTime: "60dk", recipeDifficultyLevel: "Zor"),
                recipeSavedData(recipeImage: "chicken", recipeName: "Tavuk", recipeScore: "2.5", recipeCookingTime: "50dk", recipeDifficultyLevel: "Kolay"),
                recipeSavedData(recipeImage: "chicken", recipeName: "Tavuk", recipeScore: "3.5", recipeCookingTime: "30dk", recipeDifficultyLevel: "Orta"),
                recipeSavedData(recipeImage: "chicken", recipeName: "Tavuk", recipeScore: "5.0", recipeCookingTime: "55dk", recipeDifficultyLevel: "Zor"),
                recipeSavedData(recipeImage: "chicken", recipeName: "Tavuk", recipeScore: "2.0", recipeCookingTime: "60dk", recipeDifficultyLevel: "Kolay")]
    @IBOutlet weak var recipeSavedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeSavedTableView.delegate = self
        recipeSavedTableView.dataSource = self
        // Do any additional setup after loading the view.
        
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
extension RecipeSavedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeSavedTableView.dequeueReusableCell(withIdentifier: "recipeSavedCell", for: indexPath) as! RecipeSavedTableViewCell
        cell.recipeImage.image = UIImage(named: data[indexPath.row].recipeImage)
        cell.recipeName.text = data[indexPath.row].recipeName
        cell.recipeScore.text = data[indexPath.row].recipeScore
        cell.recipeCookingTime.text = data[indexPath.row].recipeCookingTime
        cell.recipeDifficultyLevel.text = data[indexPath.row].recipeDifficultyLevel
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            recipeSavedTableView.beginUpdates()
            data.remove(at: indexPath.row)
            recipeSavedTableView.deleteRows(at: [indexPath], with: .fade)
            recipeSavedTableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
        
        self.navigationController?.pushViewController(recipeVC, animated: true)
        // Seçilen hücrenin işlemlerini burada gerçekleştirin.
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}
