//
//  RecipeIngredientsTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit

class RecipeIngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeIngredientsTitle: UILabel!
    
    @IBOutlet weak var recipeIngredientsText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}