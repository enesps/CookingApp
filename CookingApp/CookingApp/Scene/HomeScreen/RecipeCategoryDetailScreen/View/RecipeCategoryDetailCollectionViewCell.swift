//
//  RecipeCategoryDetailCollectionViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import UIKit
import Kingfisher
class RecipeCategoryDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeScore: UILabel!
    @IBOutlet weak var recipeCookingTime: UILabel!
    @IBOutlet weak var recipeDifficultyLevel: UILabel!
    
    func configure(with recipe: Recipe) {
        // Hücre içeriğini doldurma
        if let imageURL = URL(string: recipe.imageURL!) {
            recipeImage.kf.setImage(with: imageURL)
        }
        recipeName.text = recipe.recipeName
        if let score = recipe.score{
            recipeScore.text = String(score)
        }
        
        recipeCookingTime.text = recipe.cookingTime
        recipeDifficultyLevel.text = recipe.difficultyLevel
        // recipeImageView.image = ... // Eğer bir resim varsa
        // Diğer elemanları ayarlama
    }
}
