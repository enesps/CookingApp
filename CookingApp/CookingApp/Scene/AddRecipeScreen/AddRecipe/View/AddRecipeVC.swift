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
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        self.navigationController?.navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

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
