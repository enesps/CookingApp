//
//  ButtonTableViewCell.swift
//  YapYe
//
//  Created by Enes Pusa on 16.02.2024.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Corner radius (köşe yarıçapı) ayarla
        button.layer.cornerRadius = 10 // İstenilen köşe yarıçapı değerini girin

        // Border rengini ve genişliğini ayarla
        button.layer.borderColor = UIColor.black.cgColor // Kenarlık rengini siyah olarak ayarla
        button.configuration?.imagePadding = 10
        button.layer.borderWidth = 1 // Kenarlık genişliğini ayarla
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureButton() {
           button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
       }

       @objc func buttonTapped() {
           button.showActivityIndicator()

           // Simüle edilmiş bir işlem için 2 saniye bekleyin
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               self.button.hideActivityIndicator()
           }
       }
    
}
extension UIButton {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        activityIndicator.style = .medium
        activityIndicator.color = .white
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // Disable button while showing activity indicator
        isEnabled = false
    }
    
    func hideActivityIndicator() {
        // Remove activity indicator from superview
        subviews.forEach { $0.removeFromSuperview() }
        
        // Enable button after hiding activity indicator
        isEnabled = true
    }
}
