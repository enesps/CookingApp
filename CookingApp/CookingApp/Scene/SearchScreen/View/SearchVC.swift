//
//  SearchVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//

import Foundation
import UIKit
import Combine
import SkeletonView
import Lottie
class SearchVC:UIViewController{
    @IBOutlet weak var recipeSearchTableView: UITableView!
    var refreshControl = UIRefreshControl()
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = RecipeSearchVM()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name: "LottieAnimationSpinner")
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
        
        
        recipeSearchTableView.dataSource = self
        recipeSearchTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        recipeSearchTableView.addSubview(refreshControl)
        recipeSearchTableView.register(UINib(nibName: "RecipeCardTableViewCell", bundle: nil), forCellReuseIdentifier: "XibCard")
        navigationItem.title = "Yemek Tarifi Ara"
        viewModel.onSkeletonUpdate = { [weak self] isActive in
            if isActive {
                self?.recipeSearchTableView.isSkeletonable = true
                self?.recipeSearchTableView.showAnimatedGradientSkeleton()
            } else {
                self?.recipeSearchTableView.stopSkeletonAnimation()
                self?.view.hideSkeleton()
            }
        }
        viewModel.onDataUpdate = { [weak self]   in
            
            self?.recipeSearchTableView.reloadData()
            animationView.stop()
            animationView.isHidden = true
        }
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipes)")
        
        configureSearchController()
    }
    @objc func refresh(){
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipes)")
        self.refreshControl.endRefreshing()
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

extension SearchVC: UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate,SkeletonTableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? viewModel.filteredData.count : viewModel.data!.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "XibCard"
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch (selectedScope){
        case 0 :
            recipeSearchTableView.reloadData()
        case 1 :
            break
        default: break
            
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe: Recipe
        if searchController.isActive {
            recipe = viewModel.filteredData[indexPath.item]
        }
        else{
            recipe = viewModel.data![indexPath.item]
            
        }
        let cell = recipeSearchTableView.dequeueReusableCell(withIdentifier: "XibCard", for: indexPath)  as! RecipeCardTableViewCell
        cell.configure(with: recipe)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        return  searchController.isActive ? String (format:"%d Sonuç bulundu", viewModel.filteredData.count ) : String (format:"%d Sonuç bulundu", viewModel.data!.count )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        if searchText.isEmpty {
            viewModel.filteredData = (viewModel.data)!
        } else {
            let filteredData = viewModel.data?.filter { recipe in
                if let recipeName = recipe.recipeName {
                    return recipeName.lowercased().contains(searchText)
                }
                else {
                    return false
                }
            }
            viewModel.filteredData = filteredData!
        }
        recipeSearchTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Burada istediğiniz işlemleri gerçekleştirin
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipes)")
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
            viewModel.fetchDataSearch(for: ["foodName" : searchText],endpoint: APIEndpoints.getRecipeSearch)
        } else {
            recipeSearchTableView.reloadData()
        }
        
    }
}
