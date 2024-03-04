//
//  RecipeCategoryDetailVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import UIKit
import Combine
import Kingfisher
import SkeletonView
import Lottie
class RecipeCategoryDetailVC: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = RecipeCategoryDetailVM()
    var searchController = UISearchController(searchResultsController: nil)
    var categoryTitle : String?
    var refreshControl = UIRefreshControl()
    let animationView = LottieAnimationView(name: "LottieAnimationSpinner")
    
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = categoryTitle
        lottieAnimation()
        configureCollectionView()
        configureSearchController()
        dataUpdate()
        SkeletonUpdate()
        viewModel.fetchData(endpoint:"\(APIEndpoints.getRecipeCategory)\(viewModel.manipulateString(viewModel.convertTurkishToEnglish(categoryTitle!)))")
        
    }
    private func dataUpdate(){
        viewModel.onDataUpdate = { [weak self]   in
            self?.recipeCollectionView.reloadData()
            self?.animationView.stop()
            self?.animationView.isHidden = true
            
        }

    }
    private func SkeletonUpdate(){
        viewModel.onSkeletonUpdate = { [weak self] isActive in
            if isActive {
                self?.recipeCollectionView.isSkeletonable = true
                self?.recipeCollectionView.showAnimatedGradientSkeleton()
            } else {
                self?.recipeCollectionView.stopSkeletonAnimation()
                self?.view.hideSkeleton()
            }
        }
    }
    private func lottieAnimation(){
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        animationView.isHidden = false
        animationView.loopMode = .loop
        animationView.play()
    }
    @objc func refresh(){
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipeCategory)\(viewModel.manipulateString(viewModel.convertTurkishToEnglish(categoryTitle!)))")
        self.refreshControl.endRefreshing()
    }
    private func configureCollectionView(){
        
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipeCollectionView.contentInset = UIEdgeInsets.zero
        recipeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = recipeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 5
            flowLayout.minimumLineSpacing = 5
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // Ekran kenarlarına olan boşluk
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        recipeCollectionView.addSubview(refreshControl)
    }
    
    private func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["Tümü","Zorluğa göre","Yıldıza gore"]
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Tarifinizi Bulun"
    }
}

extension RecipeCategoryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UISearchResultsUpdating,UISearchBarDelegate,UICollectionViewDelegateFlowLayout,SkeletonCollectionViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "cell1"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? viewModel.filteredData.count : viewModel.data!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recipe: Recipe
        if searchController.isActive {
            recipe = viewModel.filteredData[indexPath.item]
        }
        else{
            recipe = viewModel.data![indexPath.item]
            
        }
        let cell = recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        as! RecipeCategoryDetailCollectionViewCell
        cell.configure(with: recipe)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 2
        cell.layer.masksToBounds = false


        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
        if searchController.isActive
        {
            recipeVC.recipeId = viewModel.filteredData[indexPath.row].id
        }
        else
        {
            
            
            recipeVC.recipeId = viewModel.data?[indexPath.row].id
            
        }
        
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (recipeCollectionView.frame.size.width - 18) / 2
        return CGSize(width: width, height:173)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.recipeCollectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    func updateSearchResults(for searchController: UISearchController) {
        // Arama sorgusunu alın
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        if searchText.isEmpty {
            viewModel.filteredData = (viewModel.data)!
        } else {
            // Verileri filtrele
            let filteredData = viewModel.data?.filter { recipe in
                if let recipeName = recipe.recipeName {
                    return recipeName.lowercased().contains(searchText)
                } else {
                    return false
                }
            }
            
            viewModel.filteredData = filteredData!
        }
        
        recipeCollectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Burada istediğiniz işlemleri gerçekleştirin
        viewModel.fetchData(endpoint:"\(APIEndpoints.getRecipeCategory)\(viewModel.manipulateString(viewModel.convertTurkishToEnglish(categoryTitle!)))")
        
        // Örneğin, arama ekranını kapatmak için aşağıdaki satırı ekleyebilirsiniz:
        // dismiss(animated: true, completion: nil)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else { return }
        
        let filteredData = viewModel.data?.filter { recipe in
            if let recipeName = recipe.recipeName {
                return recipeName.lowercased().contains(searchText)
            } else {
                return false
            }
        }
        
        viewModel.filteredData = filteredData!
        if filteredData!.isEmpty {
            animationView.isHidden = false
            animationView.loopMode = .loop
            animationView.play()
            viewModel.fetchData1(for: ["foodName" : searchText],endpoint: APIEndpoints.getRecipeSearch)
            animationView.stop()
            animationView.isHidden = true
        } else {
            recipeCollectionView.reloadData()
        }
    }
}
