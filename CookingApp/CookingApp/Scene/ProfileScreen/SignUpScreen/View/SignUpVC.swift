//
//  SignUpVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 23.11.2023.
//

import UIKit
import GoogleSignIn
import KeychainAccess
class SignUpVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    let viewModel = SignUpVM()
    var keychain = KeyChainService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Üye Ol"

        
        
        // Do any additional setup after loading the view.
    }
    

//    @IBAction func goToLoginVC(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    @IBAction func signUpGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }

            let user = signInResult.user
            
            let emailAddress = user.profile?.email
            
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            let token = user.idToken
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
//            print("username:\(token)")
//            print(user.idToken?.tokenString)
            KeyChainService.shared.saveToken(user.idToken!.tokenString)
           
            tokenSignInExample(idToken: KeyChainService.shared.readToken() ?? "")
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettings") as? ProfileNC else { return }
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
          // If sign in succeeded, display the app's main content View.
        }
        
        func tokenSignInExample(idToken: String) {
            guard let authData = try? JSONEncoder().encode(["idToken": idToken]) else {
                return
            }
            let url = URL(string: "https://bk-going-loads-tutorials.trycloudflare.com/v1/members/login/google")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.uploadTask(with: request, from: authData) { data, response, error in
 
            }
            
            task.resume()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
