//
//  RecipeCardTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 4.12.2023.
//

import UIKit

class RecipeCardTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeCardScore: UILabel!
    
    @IBOutlet weak var recipeCardName: UILabel!
    @IBOutlet weak var recipeCardDifficultyLevel: UILabel!
    @IBOutlet weak var recipeCardCookingTime: UILabel!
    @IBOutlet weak var recipeCardStarIcon: UIImageView!
    @IBOutlet weak var recipeCardImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
