//
//  AddRecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 2.01.2024.
//

import UIKit

class AddRecipeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickAddRecipe(_ sender: Any) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "AddRecipeDetailVC") as! AddRecipeDetailVC
        self.navigationController?.pushViewController(recipeVC, animated: true)
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
