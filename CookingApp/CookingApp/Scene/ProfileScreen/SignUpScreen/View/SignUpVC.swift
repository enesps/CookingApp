//
//  SignUpVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 23.11.2023.
//

import UIKit
import GoogleSignIn
class SignUpVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Üye Ol"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToLoginVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
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
            print("username:\(token)")
            print(user.idToken?.tokenString)

          // If sign in succeeded, display the app's main content View.
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
