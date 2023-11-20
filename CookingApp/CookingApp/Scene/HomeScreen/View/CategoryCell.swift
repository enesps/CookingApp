//
//  CategoryCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//
import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Gerekirse hücre görünümünü özelleştirme
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
}
