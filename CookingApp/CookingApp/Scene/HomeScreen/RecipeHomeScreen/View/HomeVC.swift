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
import Combine
import Kingfisher
import SPIndicator
class HomeVC : ViewController{
    
    @IBOutlet weak var recipeCategoryCollectionView: UICollectionView!
    let recipeCategoryTitle: [String] = ["Çorbalar","Ana Yemekler","Tatlılar","İçecekler"]
    let recipeCategoryImage: [String] = ["soup","main-food","dessert","drink"]
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = RecipeHomeVM()
    var imageUrl : URL? = nil
    override func viewDidLoad() {
        
        showIndicatorView()
        dataUpdate()
        fetchData()
        configCollectionView()
    }
    
    
    func fetchData(){
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipeDaily)")
    }
    func showIndicatorView(){
        let indicatorView = SPIndicatorView(title: "Hoşgeldiniz",message: "Sizleri görmekten mutluyuz.", preset: .done)
        indicatorView.present(duration: 3)
    }
    func configCollectionView(){
        recipeCategoryCollectionView.dataSource = self
        recipeCategoryCollectionView.delegate = self
        recipeCategoryCollectionView.register(UINib(nibName: "RecipeImageViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeImageViewCollectionViewCell")
        recipeCategoryCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = recipeCategoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 5  // Hücreler arasındaki minimum boşluk
            flowLayout.minimumLineSpacing = 5       // Satırlar arasındaki minimum boşluk
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // Ekran kenarlarına olan boşluk
        }
    }
    func dataUpdate(){
        viewModel.onDataUpdate = { [weak self]   in
            if let ImageUrl = self?.viewModel.data?.imageURL{
                self?.imageUrl = URL(string: (ImageUrl))
            }else{
                self?.imageUrl = URL(string: ("cdscd"))
                
            }
            self?.showPopUp(imageUrl: self?.imageUrl)
        }
    }
    
    func showPopUp(imageUrl : URL? = nil){
        // Use Kingfisher to download the image
        KingfisherManager.shared.retrieveImage(with: (imageUrl)!) { result in
            switch result {
            case .success(let value):
                let uiImage = value.image
                let popupVC = ALPopup.popup(template: .init(
                    title: "Günün Menüsü",
                    subtitle: self.viewModel.data?.recipeName,
                    image: uiImage,
                    privaryButtonTitle: "Bak",
                    secondaryButtonTitle: "Simdi Degil")
                )
                
                if let url = URL(string: (self.viewModel.data?.imageURL!)!) {
                    popupVC.tempateView.imageView.kf.setImage(with: url)
                }
                
                popupVC.tempateView.imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = false
                
                popupVC.tempateView.imageView.widthAnchor.constraint(equalToConstant: 300).isActive = false
                
                popupVC.tempateView.imageView.layer.cornerRadius = 30
                
                popupVC.tempateView.secondaryButtonAction = { [weak self] in
                    
                    popupVC.pop()
                }
                
                
                popupVC.tempateView.primaryButtonAction = {
                    popupVC.pop()
                    let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
                    recipeVC.recipeId = self.viewModel.data?.id
                    self.navigationController?.pushViewController(recipeVC, animated: true)
                }
                popupVC.push(from: (self))
            case .failure(let error):
                print("Error downloading image: \(error)")
            }
        }
    }
    
}
extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeCategoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeImageViewCollectionViewCell", for: indexPath) as! RecipeImageViewCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 15
        
        cell.recipeImageView.image = UIImage(named: recipeCategoryImage[indexPath.row])
        cell.recipeName.text = recipeCategoryTitle[indexPath.row]
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
