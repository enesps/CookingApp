//
//  SignUpVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 23.11.2023.
//

import UIKit
import GoogleSignIn
import Combine
import KeychainAccess
import SPIndicator
class SignUpVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    let viewModel = SignUpVM()
    private var cancellables: Set<AnyCancellable> = []
    var keychain = KeyChainService()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Üye Ol"
        
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
    
    
    @IBAction func goToLoginVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            self.viewModel.signInWithToken(idToken: user.idToken!.tokenString)
            
        }
        
    }
}
