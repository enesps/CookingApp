//
//  PreLoginVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//

import Foundation
import UIKit
class PreLoginVC:UIViewController{
    
    override func viewDidLoad(){
        
    }
    
    @IBAction func LoginPage(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? UIViewController else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)

    }
}
