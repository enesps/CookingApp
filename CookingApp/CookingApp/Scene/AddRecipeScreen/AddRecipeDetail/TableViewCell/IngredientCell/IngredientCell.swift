//
//  IngredientCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 3.01.2024.
//

import UIKit
import Combine
import SkyFloatingLabelTextField
class IngredientCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var amount: SkyFloatingLabelTextField!
    @IBOutlet weak var ingredient: SkyFloatingLabelTextField!
    var ingredientUpdate: ((String, String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        ingredient.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        amount.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        ingredientUpdate?(ingredient.text ?? "", amount.text ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
