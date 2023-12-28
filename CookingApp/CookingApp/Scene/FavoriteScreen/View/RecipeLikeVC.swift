//
//  RecipeLikedVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit

class RecipeLikeVC: UIViewController {
    struct recipeLike{
        var recipeImage:String
        var recipeName:String
    }
    var recipeLikeData = [recipeLike(recipeImage: "chicken", recipeName: "Tavuk"),
                          recipeLike(recipeImage: "chicken", recipeName: "Et"),
                          recipeLike(recipeImage: "chicken", recipeName: "Fasulye"),
                          recipeLike(recipeImage: "chicken", recipeName: "Sebze"),
                          recipeLike(recipeImage: "chicken", recipeName: "Dolma"),
                          recipeLike(recipeImage: "chicken", recipeName: "Manti")]
    @IBOutlet weak var recipeLikeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLikeTableView.dataSource = self
        recipeLikeTableView.delegate = self
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
extension RecipeLikeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeLikeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeLikeTableView.dequeueReusableCell(withIdentifier: "RecipeLikeCell", for: indexPath) as! RecipeLikeTableViewCell
        cell.recipeImage.image = UIImage(named: recipeLikeData[indexPath.row].recipeImage)
        cell.recipeName.text = recipeLikeData[indexPath.row].recipeName
        // Add a tap gesture recognizer to the UIImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        cell.recipeLike.isUserInteractionEnabled = true
        cell.recipeLike.tag = indexPath.row // Save the row index as a tag to identify which image was tapped
        cell.recipeLike.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
        
        self.navigationController?.pushViewController(recipeVC, animated: true)
        // Seçilen hücrenin işlemlerini burada gerçekleştirin.
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            // Get the cell containing the tapped image view
            if let cell = tappedImageView.superview?.superview as? RecipeLikeTableViewCell {
                // Get the index path of the tapped row
                if let indexPath = recipeLikeTableView.indexPath(for: cell) {
                    // Remove the data at the specified index
                    recipeLikeData.remove(at: indexPath.row)
                    
                    // Delete the corresponding row from the table view
                    recipeLikeTableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        
        
    }
}
