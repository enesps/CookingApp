//
//  PreLoginVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//

import Foundation
import UIKit
import KeychainAccess
class PreLoginVC:UIViewController{
   
    override func viewDidLoad(){
        navigationItem.title = "Profilim"
       
    }
    
    @IBAction func LoginPage(_ sender: Any) {
        print(KeyChainService.shared.readToken())
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? UIViewController else { return }
        let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        
    }
}
