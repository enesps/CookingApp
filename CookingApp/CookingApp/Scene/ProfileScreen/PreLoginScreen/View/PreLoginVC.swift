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
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
}
