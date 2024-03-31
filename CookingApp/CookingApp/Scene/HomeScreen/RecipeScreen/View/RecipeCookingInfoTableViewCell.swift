//
//  RecipeCookingInfoTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 18.12.2023.
//

import UIKit

class RecipeCookingInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var servesFor: UILabel!
    
    @IBOutlet weak var cookingTime: UILabel!
    @IBOutlet weak var preparationTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func config(with  recipeTime: recipeTimer){
       servesFor.text = recipeTime.servesFor
       cookingTime.text = recipeTime.cookingTime
       preparationTime.text = recipeTime.preparationTime
    }
    
}
