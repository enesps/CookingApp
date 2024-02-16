//
//  externalLoginTableViewCell.swift
//  YapYe
//
//  Created by Enes Pusa on 16.02.2024.
//

import UIKit

class externalLoginTableViewCell: UITableViewCell {

    @IBOutlet weak var loginFacebook: UIButton!
    @IBOutlet weak var loginGoogle: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
