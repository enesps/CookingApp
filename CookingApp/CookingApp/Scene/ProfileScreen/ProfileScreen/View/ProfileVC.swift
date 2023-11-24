//
//  ProfileVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 24.11.2023.
//

import UIKit

class ProfileVC: UIViewController {


    @IBOutlet weak var profileBtn: UIImageView!
    
    @IBOutlet weak var recipeView: UIControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileBtn.layer.cornerRadius = 40 //
        profileBtn.layer.masksToBounds = true //
        
    }

    @IBAction func onClickSettings(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettings") as? UIViewController else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    @IBAction func onClickFixProfile(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FixProfile") as? UIViewController else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    

    @IBAction func onClickRecipeView(_ sender: Any) {
        print("clicked recipeView")

    }
    
    @IBAction func onClickFollower(_ sender: Any) {
        print("clicked follewer")
    }
    
    

    @IBAction func onClickFollowing(_ sender: Any) {
        print("clicked following")
    }
    
}
