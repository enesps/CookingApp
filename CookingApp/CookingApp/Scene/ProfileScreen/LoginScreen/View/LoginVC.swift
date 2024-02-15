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

    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!

    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var rememberMeCheckbox: UIButton!
    var rememberMeChecked: Bool = false {
        didSet {
            let imageName = rememberMeChecked ? "checkmark.square.fill" : "square"
            rememberMeCheckbox.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    private var viewModel = LoginVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Giriş Yap"
        userNameTextField.borderStyle = .none
        userNameTextField.setCustomPlaceholder(text: "Kullanici Adi")
        userNameTextField.customize()
        passwordTextField.setCustomPlaceholder(text: "Sifre")
        passwordTextField.customize()
        passwordTextField.addPasswordToggleImage()
        // Metin rengi

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue, // Rengi burada mavi olarak ayarlayabilirsiniz
            .underlineStyle: NSUnderlineStyle.single.rawValue // Altı çizili stil
        ]
        let attributedString = NSAttributedString(string: "Şifremi Unuttum", attributes: attributes)
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        rememberMeCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
               rememberMeCheckbox.addTarget(self, action: #selector(rememberMeCheckboxTapped(_:)), for: .touchUpInside)
//        userNameTextField.rightView?.frame.origin.x -= 50 // Sağa kaydır
        
        // Kenarlık özellikleri
       
        viewModel.onDataUpdate = { [weak self] model, error in
            DispatchQueue.main.async {
                if let token = model?.token{
                    KeyChainService.shared.saveToken(token)
                }
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
    @objc func rememberMeCheckboxTapped(_ sender: UIButton) {
        rememberMeChecked.toggle()
    }
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

extension UITextField {
    func customize() {
        // Placeholder metni oluştur
        

        // Kenarlık özellikleri
        self.layer.cornerRadius = 5.0 // Köşe yuvarlatma
        self.layer.borderWidth = 2.0 // Kenarlık kalınlığı
        
        self.layer.borderColor = UIColor.silver.cgColor
        // Parlaklık efekti
        self.layer.shadowColor = UIColor.silver.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius = 4.0
    }
    func setCustomPlaceholder(text: String) {
        let placeholderText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 14)!])
        
        // Sol boşluk için bir boşluk ekleyin
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = spaceView
        self.leftViewMode = .always
        
        // Placeholder'ı ata
        self.attributedPlaceholder = placeholderText
    }
    func addPasswordToggleImage() {
           let button = UIButton(type: .custom)
           button.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Kapalı durumda başlat
           button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
           button.contentMode = .scaleAspectFit
           button.tintColor = .black // Göz simgesi rengi
           button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
           self.rightView = button
           self.rightViewMode = .always
       }

       @objc func togglePasswordVisibility(_ sender: UIButton) {
           self.isSecureTextEntry.toggle()
           if let textRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument) {
               self.replace(textRange, withText: self.text ?? "")
           }
           
           // Göz simgesinin durumunu güncelleyin
           if self.isSecureTextEntry {
               sender.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Kapalı ise göster
           } else {
               sender.setImage(UIImage(systemName: "eye"), for: .normal) // Açık ise göster
           }
       }
}
