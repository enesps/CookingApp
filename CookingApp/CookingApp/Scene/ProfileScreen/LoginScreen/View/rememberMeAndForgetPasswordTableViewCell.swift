//
//  rememberMeAndForgetPasswordTableViewCell.swift
//  YapYe
//
//  Created by Enes Pusa on 16.02.2024.
//

import UIKit

class rememberMeAndForgetPasswordTableViewCell: UITableViewCell {

    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    var rememberMeChecked: Bool = false {
        didSet {
            let imageName = rememberMeChecked ? "checkmark.square.fill" : "square"
            rememberMeButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue, // Rengi burada mavi olarak ayarlayabilirsiniz
            .underlineStyle: NSUnderlineStyle.single.rawValue // Altı çizili stil
        ]
        let attributedString = NSAttributedString(string: "Şifremi Unuttum", attributes: attributes)
        forgetPasswordButton.setAttributedTitle(attributedString, for: .normal)
        rememberMeButton.setImage(UIImage(systemName: "square"), for: .normal)
        rememberMeButton.addTarget(self, action: #selector(rememberMeCheckboxTapped(_:)), for: .touchUpInside)
        // Initialization code
    }
    @objc func rememberMeCheckboxTapped(_ sender: UIButton) {
        rememberMeChecked.toggle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
