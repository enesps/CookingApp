//
//  IngredientCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 3.01.2024.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var ingredient: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
