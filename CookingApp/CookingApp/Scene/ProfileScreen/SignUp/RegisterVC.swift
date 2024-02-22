//
//  RegisterVC.swift
//  YapYe
//
//  Created by Enes Pusa on 22.02.2024.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfigure()

        // Do any additional setup after loading the view.
    }
    func tableViewConfigure(){
        tableView.separatorStyle = .none
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelTableViewCell")
         tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
         tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
         tableView.register(UINib(nibName: "rememberMeAndForgetPasswordTableViewCell", bundle: nil), forCellReuseIdentifier: "rememberMeAndForgetPasswordTableViewCell")

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
extension RegisterVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTableViewCell", for: indexPath) as! LabelTableViewCell
            cell.label.text = "Şifrenizi oluşturunuz."
            
            cell.selectionStyle = .none
            
            return cell
        }

        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.textField.placeholder = "Şifrenizi girin"
            cell.textField.title = "Şifre"
            cell.textField.tintColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.textColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
            cell.textField.lineColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.selectedTitleColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.selectedLineColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)

            cell.textField.lineHeight = 1.0 // bottom line height in points
            cell.textField.selectedLineHeight = 2.0
            cell.textField.errorColor = UIColor.red

//            cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.textField.becomeFirstResponder()
            cell.selectionStyle = .none
           return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.textField.placeholder = "Şifrenizi tekrar girin"
            cell.textField.title = "Tekrar giriniz"
            cell.textField.tintColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.textColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
            cell.textField.lineColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.selectedTitleColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.textField.selectedLineColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)

            cell.textField.lineHeight = 1.0 // bottom line height in points
            cell.textField.selectedLineHeight = 2.0
            cell.textField.errorColor = UIColor.red

//            cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.textField.becomeFirstResponder()
            cell.selectionStyle = .none
           return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.button.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            cell.button.setTitleColor(UIColor.white, for: .normal)
            cell.button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            cell.button.setTitle("Devam et" ,for: .normal)
            cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
//    @objc func textFieldDidChange(_ textfield: UITextField) {
//        if let text = textfield.text {
//            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
//                if text.count < 3 || !text.contains("@") {
//                    if !text.isEmpty {
//                        floatingLabelTextField.errorColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
//                        floatingLabelTextField.errorMessage = "Geçersiz email"
//                        if let buttonCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? ButtonTableViewCell {
//                            buttonCell.button.isEnabled = false
//                            buttonCell.button.layer.borderWidth = 0 // Kenarlık genişliğini ayarla
//                            buttonCell.button.setTitle("Devam et", for: .normal)
//                            buttonCell.button.setTitleColor(UIColor.blue, for: .normal)
//                            buttonCell.button.backgroundColor = UIColor.white
//                    }
//                    
//                    }
//                } else {
//                    // Geçerli e-posta girildiğinde
//                    floatingLabelTextField.errorMessage = ""
//                    if let buttonCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? ButtonTableViewCell {
//                        buttonCell.button.isEnabled = true
//                        buttonCell.button.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
//                        buttonCell.button.layer.borderWidth = 1
//                        buttonCell.button.setTitleColor(UIColor.white, for: .normal)
//                        buttonCell.button.setTitle("Devam et" ,for: .normal)
//                    }
//                }
//            }
//        }
//    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var flag = false
        sender.showActivityIndicator()
        // Simüle edilmiş bir işlem için 2 saniye bekleyin
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.hideActivityIndicator()


                            let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                            tabBarController.selectedIndex = 4
                            tabBarController.modalPresentationStyle = .overFullScreen
                            self.present(tabBarController, animated: true, completion: nil)
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

