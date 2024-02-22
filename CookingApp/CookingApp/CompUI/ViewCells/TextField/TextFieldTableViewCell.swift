//
//  TableViewCell.swift
//  YapYe
//
//  Created by Enes Pusa on 16.02.2024.
//

import UIKit
import SkyFloatingLabelTextField

class TextFieldTableViewCell: UITableViewCell , UITextFieldDelegate {

  
    
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.layer.cornerRadius = 5 // İstenilen corner radius değerini ayarlayabilirsiniz
               textField.layer.masksToBounds = true // Köşe yuvarlatma işlemini etkinleştirir
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // TextField'in border rengini mavi olarak ayarla
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor.blue.cgColor
//    }
    
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
