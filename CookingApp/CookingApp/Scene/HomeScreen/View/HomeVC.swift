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
                                                title: "Günün Menüsü",
                                                subtitle: "Zeytinyagli Yaprak Sarması",
                                                image: UIImage(named: "zeytinyagli-yaprak"),
                                                privaryButtonTitle: "Bak",
                                                secondaryButtonTitle: "Simdi Degil")
                        )

        popupVC.tempateView.secondaryButtonAction = { [weak self] in
            
            popupVC.pop()
        }
        popupVC.push(from: self)
        
    }
}
