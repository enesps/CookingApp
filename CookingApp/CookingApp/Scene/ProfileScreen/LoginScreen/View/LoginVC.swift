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

    @IBOutlet weak var loginTableView: UITableView!
//    @IBOutlet weak var orLabel: UILabel!
//    @IBOutlet weak var loginButton: UIButton!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var userNameTextField: UITextField!
//    @IBOutlet weak var loginBtn: UIButton!
//    @IBOutlet weak var signUpBtn: UIButton!
//
//    @IBOutlet weak var forgotPasswordButton: UIButton!
//    @IBOutlet weak var rememberMeCheckbox: UIButton!
//    var rememberMeChecked: Bool = false {
//        didSet {
//            let imageName = rememberMeChecked ? "checkmark.square.fill" : "square"
//            rememberMeCheckbox.setImage(UIImage(systemName: imageName), for: .normal)
//        }
//    }
    private var viewModel = LoginVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Yap Ye"
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        self.navigationController?.navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 45)!
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
        tableViewConfigure()

//        // Metin rengi
//
//        viewModel.onDataUpdate = { [weak self] model, error in
//            DispatchQueue.main.async {
//                if let token = model?.token{
//                    KeyChainService.shared.saveToken(token)
//                }
//                let tabBarController = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//                tabBarController.selectedIndex = 4
//                tabBarController.modalPresentationStyle = .overFullScreen
//                self?.present(tabBarController, animated: true, completion: nil)
//            }
//        }
    }
    func tableViewConfigure(){
         loginTableView.delegate = self
         loginTableView.dataSource = self
         loginTableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelTableViewCell")
         loginTableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
         loginTableView.register(UINib(nibName: "externalLoginTableViewCell", bundle: nil), forCellReuseIdentifier: "externalLoginTableViewCell")
         loginTableView.register(UINib(nibName: "rememberMeAndForgetPasswordTableViewCell", bundle: nil), forCellReuseIdentifier: "rememberMeAndForgetPasswordTableViewCell")

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
//    @objc func rememberMeCheckboxTapped(_ sender: UIButton) {
//        rememberMeChecked.toggle()
//    }
    @IBAction func goToSignUpVC(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? UIViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
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
extension LoginVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = loginTableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1{
            let cell = loginTableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.button.setTitleColor(UIColor.black, for: .normal)
            cell.button.setImage(UIImage(named: "google"), for: .normal)
            cell.button.setTitle("Google ile devam et" ,for: .normal)
            cell.button.addTarget(self, action: #selector(signInGoogle(_:)), for: .touchUpInside)
            cell.button.backgroundColor = UIColor.white
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            let cell = loginTableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.button.setTitleColor(UIColor.black, for: .normal)
            cell.button.setImage(UIImage(systemName: "applelogo"), for: .normal)
            cell.button.setTitle("Facebook ile devam et" ,for: .normal)
            cell.button.backgroundColor = UIColor.white
            cell.selectionStyle = .none
           return cell
        }
        else  {
            let cell = loginTableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.button.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
            cell.button.setTitleColor(UIColor.white, for: .normal)
            
            cell.button.setTitle("E-postayla devam et" ,for: .normal)
            cell.button.addTarget(self, action: #selector(goToSignUpVC(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Hücre seçilmesini engelle
        tableView.deselectRow(at: indexPath, animated: false)
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // İstenilen boşluk miktarını burada belirleyebilirsiniz
//        if indexPath.row == 4 {
//            return 182
//        }
//        else{
//            return 64
//        }
//        // Örneğin, her hücre için 80 piksel yükseklik belirtiyoruz.
//    }
    
}
