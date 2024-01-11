//
//  InstructionViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 3.01.2024.
//

import UIKit
import SkyFloatingLabelTextField

class InstructionViewCell: UITableViewCell {
    @IBOutlet weak var instruction: SkyFloatingLabelTextField!
    
    var instructionUpdate: ((String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        instruction.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Initialization code
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        instructionUpdate?(instruction.text ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
