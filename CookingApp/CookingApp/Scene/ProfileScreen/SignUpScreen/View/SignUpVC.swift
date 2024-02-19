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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    let viewModel = SignUpVM()
    private var cancellables: Set<AnyCancellable> = []
    var keychain = KeyChainService()
    override func viewDidLoad() {
        tableViewConfigure()
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
    func tableViewConfigure(){
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelTableViewCell")
         tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
         tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
         tableView.register(UINib(nibName: "rememberMeAndForgetPasswordTableViewCell", bundle: nil), forCellReuseIdentifier: "rememberMeAndForgetPasswordTableViewCell")

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
extension SignUpVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
            cell.label.text = "E-posta adresinizi giriniz."
            cell.selectionStyle = .none
            
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
            cell.label?.text = "Bunu giriş yapmanız veya henüz bir hesabınız yoksa oluşturmanız için kullanacağız."
            cell.label?.font = UIFont.systemFont(ofSize: 16)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "E-postanizi giriniz."
            cell.selectionStyle = .none
           return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.button.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.button.setTitleColor(UIColor.white, for: .normal)
            cell.button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            cell.button.setTitle("Devam et" ,for: .normal)
            cell.configureButton()
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
extension UIButton {
    func alignVerticalCenter(padding: CGFloat = 7.0) {
        guard let imageSize = imageView?.frame.size, let titleText = titleLabel?.text, let titleFont = titleLabel?.font else {
            return
        }
        
        let titleSize = (titleText as NSString).size(withAttributes: [.font: titleFont])
        let total = imageSize.height + titleSize.height + padding
        imageEdgeInsets = UIEdgeInsets(top: -(total - imageSize.height), left: 0, bottom: 0, right: -titleSize.width)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(total - titleSize.height), right: 0)
    }
}
