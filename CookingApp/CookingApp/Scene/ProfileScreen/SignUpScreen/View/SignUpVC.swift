//
//  SignUpVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 23.11.2023.
//

import UIKit

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
