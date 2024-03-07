//
//  ProfileVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 24.11.2023.
//

import UIKit
import Combine
import Kingfisher
import SPIndicator
class ProfileVC: UIViewController {
    @IBOutlet weak var ownPostCollectionView: UICollectionView!
    @IBOutlet weak var profileUserName: UILabel!
    @IBOutlet weak var profileBtn: UIImageView!
    @IBOutlet weak var recipeView: UIControl!
    let viewModel = ProfileVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Profilim"
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        self.navigationController?.navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        viewModel.onDataUpdate = { [weak self] model, error in
            if let model = model {

//                self?.navigationItem.title = "\(model.name!) \(model.surname!)"
                self?.profileUserName.text = model.email
                self?.profileBtn.kf.setImage(with: URL(string:model.profilePicURL!))
                self?.ownPostCollectionView.reloadData()

            }
        }
        
        viewModel.signInWithToken(idToken: KeyChainService.shared.readToken() ?? "")
        navigationSettingsItem()
        setupCollectionView()
        setUpProfileImage()
        
    }
    func navigationSettingsItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill")?.withTintColor(.lightGray),
            style: .plain,
            target: self,
            action: #selector(ayarlarButtonTapped)
        )
    }
    func setUpProfileImage(){
        profileBtn.layer.cornerRadius = 40
        profileBtn.layer.masksToBounds = true
    }
    func setupCollectionView(){
        ownPostCollectionView.delegate = self
        ownPostCollectionView.dataSource = self
        ownPostCollectionView.register(UINib(nibName: "RecipeImageViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeImageViewCollectionViewCell")
        ownPostCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = ownPostCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0 // Hücreler arasındaki minimum boşluk
            flowLayout.minimumLineSpacing = 0       // Satırlar arasındaki minimum boşluk
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)  // Ekran kenarlarına olan boşluk
        }
    }
    @objc func ayarlarButtonTapped() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettings") as? ProfileSettingsVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    @IBAction func onClickSettings(_ sender: Any) {
    //        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettings") as? ProfileSettingsVC else { return }
    //        vc.modalPresentationStyle = .popover
    //        self.present(vc, animated: true)
    //    }
    @IBAction func onClickShareProfile(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileShare") as? ProfileShareVC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
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
        return viewModel.data?.recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ownPostCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeImageViewCollectionViewCell", for: indexPath) as! RecipeImageViewCollectionViewCell
        if viewModel.data?.recipes?[indexPath.row].image == nil{
            cell.recipeImageView.image = UIImage(named: "chicken")
        }else{
            cell.recipeImageView.image = UIImage(base64String: viewModel.data?.recipes?[indexPath.row].image ?? "")
        }
//        if let imageURL = URL(string: viewModel.data?.recipes?[indexPath.row].imageURL ?? "") {
//            print(imageURL)
//            cell.recipeImageView.kf.setImage(with: imageURL)
//        }else{
//            cell.recipeImageView.image = UIImage(base64String: viewModel.data?.recipes?[indexPath.row].image ?? "")
//        }
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
        recipeVC.recipeId = viewModel.data?.recipes?[indexPath.row].id
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }
    
}
