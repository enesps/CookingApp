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
    func configure(with recipe : Recipe){
        recipeCardName.preferredMaxLayoutWidth = recipeCardName.frame.size.width
        print(recipe.recipeName)
        if let score = recipe.score{
            recipeCardScore.text = String(score)
        }
        recipeCardName.text = recipe.recipeName
        recipeCardDifficultyLevel.text = recipe.difficultyLevel
        recipeCardCookingTime.text = recipe.totalTime?.replacingOccurrences(of: "dakika", with: "dk")
        print(recipe.imageURL)
        if let imageURL = URL(string: recipe.imageURL ?? "") {
            print(imageURL)
            recipeCardImage.kf.setImage(with: imageURL)
        }else{
            recipeCardImage.image = UIImage(named: "chicken")
        }
        
    }
}
