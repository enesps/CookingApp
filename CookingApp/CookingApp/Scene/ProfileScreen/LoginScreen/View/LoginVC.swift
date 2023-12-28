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
    
//    @IBOutlet weak var forgetPassword: UIButton!
//    @IBOutlet weak var userName: UITextField!
//    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!

    private var viewModel = LoginVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Giriş Yap"
        viewModel.onDataUpdate = { [weak self] model, error in
            DispatchQueue.main.async {
                if let token = model?.token{
                    KeyChainService.shared.saveToken(token)
                    print(token)
                }
                print(KeyChainService.shared.readToken())
                let tabBarController = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                tabBarController.selectedIndex = 4
                tabBarController.modalPresentationStyle = .overFullScreen
                self?.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
    
//    @IBAction func goToForgetPasswordVC(_ sender: Any) {
//        
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetVC") as? UIViewController else { return }
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromTop
//        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
//        self.navigationController?.pushViewController(vc, animated: false)
//        
//    }
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
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            self.viewModel.signInWithToken(idToken: user.idToken!.tokenString)
        }
    }
    
}
