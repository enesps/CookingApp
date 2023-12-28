//
//  RecipeLikeTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit

class RecipeLikeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var recipeLike: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
