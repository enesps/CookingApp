//
//  RecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit

class RecipeVC: UIViewController {

    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipeName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = recipeName
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! RecipeButtonGroupTableViewCell
            cell.recipeLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.recipeLikeBtn.titleLabel?.text = "3.24"
            cell.recipeShareBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
            cell.recipeShareBtn.titleLabel?.text = "Kaydet"
            return cell

        
        
    }
    
    
    
}
