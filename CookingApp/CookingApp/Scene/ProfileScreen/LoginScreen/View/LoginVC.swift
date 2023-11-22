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
    @IBOutlet weak var GoogleSignInButton: GIDSignInButton!
    
    override func viewDidLoad(){
        GoogleSignInButton.layer.cornerRadius = 15
        
    }
    
}
