//
//  FavoriteVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit

class FavoriteVC: UIViewController {
    var bottomLine: CALayer!
    @IBOutlet weak var ifNoData: UIView!
    @IBOutlet weak var recipeLike: UIView!
    @IBOutlet weak var recipeSaved: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Segment kontrolünün görünümünü özelleştirme
        segmentController.selectedSegmentTintColor = UIColor.clear
        segmentController.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)], for: .selected)
        

        
        
        // Gece modu için alt çizgi ekleyin
        addBottomLine()
        self.view.bringSubviewToFront(recipeSaved)
        // Do any additional setup after loading the view.
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Segment kontrolünün değeri değiştiğinde yapılacak işlemler
        moveBottomLine(to: sender.selectedSegmentIndex)
    }
    
    func addBottomLine() {
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: (segmentController.frame.height - 1), width: segmentController.frame.width / CGFloat(segmentController.numberOfSegments), height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1) // Seçili olan segment rengiyle aynı
        segmentController.layer.addSublayer(bottomLine)
    }
    
    func moveBottomLine(to index: Int) {
        let segmentWidth = segmentController.frame.width / CGFloat(segmentController.numberOfSegments)
        let xPosition = segmentWidth * CGFloat(index)
        
        UIView.animate(withDuration: 0.3) {
            self.bottomLine.frame.origin.x = xPosition
        }
    }
    
    @IBAction func onClickSegment(_ sender: UISegmentedControl) {
        // Segment kontrolünün değeri değiştiğinde yapılacak işlemler
        moveBottomLine(to: sender.selectedSegmentIndex)
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
