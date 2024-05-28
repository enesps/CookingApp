//
//  RecipeHeaderTableViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 5.12.2023.
//

import UIKit

class RecipeHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var recipe: UILabel!
    @IBOutlet weak var recipeFollowProfile: UIButton!
    @IBOutlet weak var recipeProfileName: UILabel!
    @IBOutlet weak var recipeProfileImage: UIImageView!
    @IBOutlet weak var recipeLikeBtn: UIButton!
    
    @IBOutlet weak var recipeShareBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with header: Recipe) {
        if header.liked == true{
            recipeLikeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else
        {
            recipeLikeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        if header.saved == true{
            recipeShareBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }else
        {
            recipeShareBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        recipeLikeBtn.setTitle(String(header.likeCount ?? 0), for: .normal)
        recipeShareBtn.titleLabel?.text = "Kaydet"

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
