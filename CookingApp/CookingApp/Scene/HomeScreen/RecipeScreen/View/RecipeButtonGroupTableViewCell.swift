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
        self.layoutMargins = UIEdgeInsets.zero
        recipeLikeBtn.addTarget(self, action: #selector(clickedRecipeLikeBtn), for: .touchDragInside)
        recipeShareBtn.addTarget(self, action: #selector(onClickSaveBtn), for: .touchDragInside)
       
    }

    @IBAction func clickedRecipeLikeBtn(_ sender: Any) {
        if recipeLikeBtn.isSelected {
            recipeLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else{
            recipeLikeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        recipeLikeBtn.isSelected.toggle()
    }
    
    @IBAction func onClickSaveBtn(_ sender: Any) {
        if recipeShareBtn.isSelected {
            recipeShareBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        else{
            recipeShareBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        recipeShareBtn.isSelected.toggle()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
