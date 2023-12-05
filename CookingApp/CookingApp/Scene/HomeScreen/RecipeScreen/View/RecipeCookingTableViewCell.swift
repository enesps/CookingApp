//
//  RecipeCookingTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 5.12.2023.
//

import UIKit

class RecipeCookingTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeStepNumber: UILabel!
    @IBOutlet weak var recipeStepCooking: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
