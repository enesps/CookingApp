//
//  LoginVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//


import Foundation
import UIKit
import Combine
import GoogleSignIn
class LoginVC:UIViewController{
  
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    private var viewModel = LoginVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad(){
      super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Giriş Yap"
        userName.publisher(for: \.text)
            .sink { [weak self] username in
                self?.viewModel.username = username!
            }
            .store(in: &cancellables)
        
        password.publisher(for: \.text)
            .sink { [weak self] password in
                self?.viewModel.password = password!
            }
            .store(in: &cancellables)
        
        // Combine ile butonun aktif durumunu takip et
        viewModel.isLoginButtonEnabled
                    .sink { [weak self] isEnabled in
                        self?.loginBtn.isEnabled = isEnabled
                    }
                    .store(in: &cancellables)
                
        // Butonu başlangıçta devre dışı bırak
        loginBtn.isEnabled = false

    }
    
    @IBAction func goToForgetPasswordVC(_ sender: Any) {
       
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetVC") as? UIViewController else { return }
        let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    @IBAction func goToSignUpVC(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? UIViewController else { return }
        let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
   
    }
    
}
