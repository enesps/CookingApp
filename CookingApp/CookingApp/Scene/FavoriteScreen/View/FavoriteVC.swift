//
//  FavoriteVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var recipeLike: UIView!
    @IBOutlet weak var recipeSaved: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(recipeSaved)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            self.view.bringSubviewToFront(recipeSaved)
        case 1:
            self.view.bringSubviewToFront(recipeLike)
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
