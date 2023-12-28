//
//  ProfileShareVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.12.2023.
//

import Foundation
import UIKit
import SPIndicator
class ProfileShareVC: UIViewController{
    @IBOutlet weak var QrImageView: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()

           // Replace "YourProfileData" with the actual data you want to encode in the QR code
           let profileData = "YourProfileData"
           
           if let qrCode = generateQRCode(from: profileData) {
               QrImageView.image = qrCode
           }
        
       }
       
       func generateQRCode(from string: String) -> UIImage? {
           let data = string.data(using: String.Encoding.ascii)
           
           if let filter = CIFilter(name: "CIQRCodeGenerator") {
               filter.setValue(data, forKey: "inputMessage")
               let transform = CGAffineTransform(scaleX: 3, y: 3) // Adjust the scale as needed
               if let output = filter.outputImage?.transformed(by: transform) {
                   return UIImage(ciImage: output)
               }
           }
           
           return nil
       }
    
    @IBAction func ProfileShareBtn(_ sender: Any) {
        if let qrCodeData = "YourProfileData".data(using: .utf8) {
            let activityViewController = UIActivityViewController(activityItems: [qrCodeData, "Profilimi paylaşmak için bu bağlantıyı kullanın:"], applicationActivities: nil)
               present(activityViewController, animated: true)
        }
    }
    
}
