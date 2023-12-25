//
//  ProfileVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 24.11.2023.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var ownPostCollectionView: UICollectionView!
    
    @IBOutlet weak var profileBtn: UIImageView!
    
    @IBOutlet weak var recipeView: UIControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        ownPostCollectionView.delegate = self
        ownPostCollectionView.dataSource = self
        ownPostCollectionView.register(UINib(nibName: "RecipeImageViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeImageViewCollectionViewCell")
        ownPostCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = ownPostCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0 // Hücreler arasındaki minimum boşluk
            flowLayout.minimumLineSpacing = 0       // Satırlar arasındaki minimum boşluk
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)  // Ekran kenarlarına olan boşluk
        }
        profileBtn.layer.cornerRadius = 40 //
        profileBtn.layer.masksToBounds = true //
        
    }

    @IBAction func onClickSettings(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettings") as? ProfileSettingsVC else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    @IBAction func onClickShareProfile(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettings") as? ProfileSettingsVC else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    
    @IBAction func onClickFixProfile(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FixProfile") as? UIViewController else { return }
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true)
    }
    

    @IBAction func onClickRecipeView(_ sender: Any) {
        print("clicked recipeView")

    }
    
    @IBAction func onClickFollower(_ sender: Any) {
        print("clicked follewer")
    }
    
    

    @IBAction func onClickFollowing(_ sender: Any) {
        print("clicked following")
    }
    
}
extension ProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ownPostCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeImageViewCollectionViewCell", for: indexPath) as! RecipeImageViewCollectionViewCell
        cell.recipeImageView.image = UIImage(named: "chicken-1")
        cell.recipeName.isHidden = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Hücre boyutunu ayarlayın (Instagram profil sayfasındaki gibi özel boyutlar kullanabilirsiniz)
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth / 3, height: screenWidth / 3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
       
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        // Hücreler arasındaki minimum dikey boşluğu ayarlayın
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        // Hücreler arasındaki minimum yatay boşluğu ayarlayın
//        return 0
//    }
    
}
