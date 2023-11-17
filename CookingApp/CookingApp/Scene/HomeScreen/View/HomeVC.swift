//
//  HomeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 16.11.2023.
//

import Foundation
import SwiftAlertView
import ALPopup
import UIKit
class HomeVC : ViewController{
    override func viewDidLoad() {

        let popupVC = ALPopup.popup(template: .init(
                                                title: "Yaprak Dolmasi",
                                                subtitle: "Zeytinyagli Yaprak Dolmasi",
                                                image: UIImage(named: "zeytinyagli-yaprak"),
                                                privaryButtonTitle: "Bak",
                                                secondaryButtonTitle: "Simdi Degil")
                        )

        popupVC.tempateView.primaryButtonAction = { [weak self] in
            
            popupVC.pop()
        }
        popupVC.push(from: self)
        
    }
}
