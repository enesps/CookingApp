//
//  ButtonTableViewCell.swift
//  YapYe
//
//  Created by Enes Pusa on 16.02.2024.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Corner radius (köşe yarıçapı) ayarla
        button.layer.cornerRadius = 10 // İstenilen köşe yarıçapı değerini girin

        // Border rengini ve genişliğini ayarla
        button.layer.borderColor = UIColor.black.cgColor // Kenarlık rengini siyah olarak ayarla
        button.layer.borderWidth = 1 // Kenarlık genişliğini ayarla
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
