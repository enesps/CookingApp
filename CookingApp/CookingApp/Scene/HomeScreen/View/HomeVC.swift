//
//  HomeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 16.11.2023.
//

import Foundation
import SwiftAlertView
class HomeVC : ViewController{
    override func viewDidLoad() {
        SwiftAlertView.show(title: "Lorem ipsum",
                            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                            buttonTitles: "Cancel", "Ok") {
            $0.style = .dark
        }
        .onButtonClicked { _, buttonIndex in
            print("Button Clicked At Index \(buttonIndex)")
        }
    }
}
