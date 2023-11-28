//
//  RecipeProfileTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit

class RecipeProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeProfileName: UILabel!
    @IBOutlet weak var recipeProfileImage: UIImageView!
    
    @IBOutlet weak var recipeFollowProfile: UIButton!
    @IBOutlet weak var recipe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
