//
//  LoginVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//


import Foundation
import UIKit
import GoogleSignIn
class LoginVC:UIViewController{
  
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad(){
      super.viewDidLoad()
    
        
        
        
    }
    
    @IBAction func goToForgetPasswordVC(_ sender: Any) {
       
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetVC") as? UIViewController else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
        
    }
    @IBAction func goToSignUpVC(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? UIViewController else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
        
    }
    
}
