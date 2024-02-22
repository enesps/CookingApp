//
//  LoginPasswordVC.swift
//  YapYe
//
//  Created by Enes Pusa on 20.02.2024.
//

import UIKit

class LoginPasswordVC: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()
 
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableViewConfigure(){
         tableView.separatorStyle = .none
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelTableViewCell")
         tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
         tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
         tableView.register(UINib(nibName: "rememberMeAndForgetPasswordTableViewCell", bundle: nil), forCellReuseIdentifier: "rememberMeAndForgetPasswordTableViewCell")

    }
}

extension LoginPasswordVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
            cell.label.text = "Şifrenizi giriniz."
            
            cell.selectionStyle = .none
            
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
            cell.label?.text = "Bunu giriş yapmanız için kullanacağız."
            cell.label?.font = UIFont.systemFont(ofSize: 16)
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Şifrenizi giriniz."
            cell.textField.isSecureTextEntry = true
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
            cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    @objc func buttonTapped(_ sender: UIButton) {
        var flag = true
        sender.showActivityIndicator()

        // Simüle edilmiş bir işlem için 2 saniye bekleyin
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.hideActivityIndicator()
            if(flag){
                
            }else{
                
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
