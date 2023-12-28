//
//  RecipeSavedTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit

class RecipeSavedTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeScore: UILabel!
    
    @IBOutlet weak var recipeDifficultyLevel: UILabel!
    @IBOutlet weak var recipeCookingTime: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
