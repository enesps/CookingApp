//
//  ProfileSettingsVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 24.11.2023.
//

import UIKit
import GoogleSignIn
class ProfileSettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signOut(_ sender: Any) {

            KeyChainService.shared.deleteToken()
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? UIViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
    //        self.present(vc, animated: true)
            if let navigationController = self.navigationController as? ProfileNC {
                navigationController.popToRootViewController(animated: true)
                
            }
            self.navigationController?.setViewControllers([vc], animated: true)
        

    }
    
}
