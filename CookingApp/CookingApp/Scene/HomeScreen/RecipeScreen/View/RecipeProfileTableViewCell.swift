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
        recipeFollowProfile.addTarget(self, action: #selector(onClickFollow), for: .touchUpInside)
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func onClickFollow(_ sender: Any) {
       
        // Takip et butonuna basıldığında yapılacak işlemler
        if recipeFollowProfile.isSelected {
            // Eğer takip ediliyorsa, rengi ve metni değiştir
            recipeFollowProfile.setBackgroundImage(UIImage.imageWithColor(color: UIColor.systemBlue), for: .normal)
            recipeFollowProfile.setTitle("Takip Et", for: .normal)
        } else {
            // Eğer takip edilmiyorsa, rengi ve metni değiştir
            recipeFollowProfile.setBackgroundImage(UIImage.imageWithColor(color: UIColor.cyan), for: .normal)
            recipeFollowProfile.setTitle("Takip Ediliyor", for: .normal)
        }

        // Butonun durumunu tersine çevir (takip ediliyorsa takip edilmiyor yap, takip edilmiyorsa takip et yap)
        recipeFollowProfile.isSelected.toggle()
    }
}
extension UIImage {
    static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
