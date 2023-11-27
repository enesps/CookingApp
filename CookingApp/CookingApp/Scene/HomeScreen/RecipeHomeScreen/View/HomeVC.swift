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
    @IBOutlet weak var recipeCategoryCollectionView: UICollectionView!
    let recipeCategoryTitle: [String] = ["Çorbalar","Ana Yemekler","Tatlılar","İçecekler"]
    let recipeCategoryImage: [String] = ["soup","main-food","dessert","drink"]
    
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
        recipeCategoryCollectionView.dataSource = self
        recipeCategoryCollectionView.delegate = self
        recipeCategoryCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = recipeCategoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 5  // Hücreler arasındaki minimum boşluk
            flowLayout.minimumLineSpacing = 5       // Satırlar arasındaki minimum boşluk
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // Ekran kenarlarına olan boşluk
        }
        
    }
}
extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeCategoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecipeCategoryCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 15

        cell.recipeCategoryImage.image = UIImage(named: recipeCategoryImage[indexPath.row])
        cell.recipeCategoryName.text = recipeCategoryTitle[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (recipeCategoryCollectionView.frame.size.width - 20) / 2
        return CGSize(width: width, height:280)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeCategoryDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeCategoryDetail") as! RecipeCategoryDetailVC
        recipeCategoryDetailVC.categoryTitle = recipeCategoryTitle[indexPath.row]
        self.navigationController?.pushViewController(recipeCategoryDetailVC, animated: true)
        
        
    }
    
}
