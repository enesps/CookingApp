//
//  RecipeCategoryDetailCollectionViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import UIKit
import Kingfisher
class RecipeCategoryDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeName: UILabel!
    @IBOutlet private weak var recipeScore: UILabel!
    @IBOutlet private weak var recipeCookingTime: UILabel!
    @IBOutlet private weak var recipeDifficultyLevel: UILabel!
    
    func configure(with recipe: Recipe) {
        print(recipe.imageURL)
        if let imageURLString = recipe.imageURL, let imageURL = URL(string: imageURLString) {
            // imageURL bir URL ise Kingfisher ile resmi yükle
            recipeImage.kf.setImage(with: imageURL)
            recipeImage.applyCornerRadiusToTop(corners: [.topLeft, .topRight], radius: 15)
        } else if let base64String = recipe.imageURL, let imageData = UIImage(base64String: base64String) {
            // imageURL bir base64 string ise UIImage oluştur ve set et
            recipeImage.image = imageData
        } else {
            // imageURL hem URL değil hem de base64 string değilse, varsayılan bir resim kullanabilirsiniz
            print(UIImage(base64String: recipe.imageURL ?? ""))
            recipeImage.image = UIImage(named: "chicken")
        }
        recipeName.text = recipe.recipeName
        
        if let score = recipe.score{
            recipeScore.text = String(score)
        }
        
        recipeCookingTime.text = recipe.totalTime?.replacingOccurrences(of: "dakika", with: "dk")
        recipeDifficultyLevel.text = recipe.difficultyLevel
        // recipeImageView.image = ... // Eğer bir resim varsa
        // Diğer elemanları ayarlama
    }
}
extension UIImageView {
    func applyCornerRadiusToTop(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

