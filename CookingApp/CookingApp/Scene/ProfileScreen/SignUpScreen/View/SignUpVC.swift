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
import SkyFloatingLabelTextField
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
    @IBAction func goToLoginPasswordVC(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginPasswordVC") as? UIViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func goToRegisterVC(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? UIViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
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
            cell.textField.title = "E-mail"
            cell.textField.tintColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
            cell.textField.textColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
            cell.textField.lineColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)            
            cell.textField.selectedTitleColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.selectedLineColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)

            cell.textField.lineHeight = 1.0 // bottom line height in points
            cell.textField.selectedLineHeight = 2.0
            cell.textField.errorColor = UIColor.red

            cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.textField.becomeFirstResponder()
            cell.selectionStyle = .none
           return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.button.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
            cell.button.setTitleColor(UIColor.white, for: .normal)
            cell.button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            cell.button.setTitle("Devam et" ,for: .normal)
            cell.button.isEnabled = false
            cell.button.layer.borderWidth = 0 // Kenarlık genişliğini ayarla
            cell.button.setTitle("Devam et", for: .normal)
            cell.button.setTitleColor(UIColor.red, for: .normal)
            cell.button.backgroundColor = UIColor.white
            cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                if text.count < 3 || !isValidEmail(text) {
                    if !text.isEmpty {
                        floatingLabelTextField.errorColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
                        floatingLabelTextField.errorMessage = "Geçersiz email"
                        if let buttonCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? ButtonTableViewCell {
                            buttonCell.button.isEnabled = false
                            buttonCell.button.layer.borderWidth = 0 // Kenarlık genişliğini ayarla
                            buttonCell.button.setTitle("Devam et", for: .normal)
                            buttonCell.button.setTitleColor(UIColor.blue, for: .normal)
                            buttonCell.button.backgroundColor = UIColor.white
                    }
                    
                    }
                } else {
                    // Geçerli e-posta girildiğinde
                    floatingLabelTextField.errorMessage = ""
                    if let buttonCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? ButtonTableViewCell {
                        buttonCell.button.isEnabled = true
                        buttonCell.button.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
                        buttonCell.button.layer.borderWidth = 1
                        buttonCell.button.setTitleColor(UIColor.white, for: .normal)
                        buttonCell.button.setTitle("Devam et" ,for: .normal)
                    }
                }
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var flag = false
        sender.showActivityIndicator()
        // Simüle edilmiş bir işlem için 2 saniye bekleyin
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.hideActivityIndicator()
            // Call the method to navigate to the next view controller or perform the desired action
            if flag{
                self.goToLoginPasswordVC(sender)
            }
            else{
                self.goToRegisterVC(sender)
            }
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
