//
//  RecipeButtonGroupTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit

class RecipeButtonGroupTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeLikeBtn: UIButton!
    
    @IBOutlet weak var recipeShareBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func clickedRecipeLikeBtn(_ sender: Any) {
        print("enes")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
