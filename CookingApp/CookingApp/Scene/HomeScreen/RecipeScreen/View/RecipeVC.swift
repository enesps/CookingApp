//
//  RecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit

class RecipeVC: UIViewController {
    var recipeName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = recipeName
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
