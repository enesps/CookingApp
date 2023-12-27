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
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else { return }
                vc.modalPresentationStyle = .overFullScreen
                self?.navigationController?.setViewControllers([vc], animated: true)
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
