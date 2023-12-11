//
//  RecipeCategoryDetailVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import UIKit
import Combine
import Kingfisher

class RecipeCategoryDetailVC: UIViewController {
    var searching = false
    var notFound = false
    private var cancellables: Set<AnyCancellable> = []
      private let viewModel = RecipeCategoryDetailVM()
    var searchedRecipe = [RecipeModel]()
    
    var searchController = UISearchController(searchResultsController: nil)
    var categoryTitle : String?
    var recipeData = [RecipeModel]()
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = categoryTitle
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = recipeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 5  // Hücreler arasındaki minimum boşluk
            flowLayout.minimumLineSpacing = 5       // Satırlar arasındaki minimum boşluk
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)  // Ekran kenarlarına olan boşluk
        }

        
        configureSearchController()
               viewModel.onDataUpdate = { [weak self]   in
                   self?.recipeCollectionView.reloadData()
                   //            self?.recipeCollectionView.reloadData()

               }
                    viewModel.endpoint = "/v1/recipes/category/çorba"
        
       
        viewModel.fetchData()
        
               
        
        // Do any additional setup after loading the view.
    }
//    private func updateUI() {
//        if let data = viewModel.data ,
//           let recipeScrore = data.score{
//            
//            searchedRecipe.append(RecipeModel(recipeImage:data.imageURL! , recipeName: data.recipeName!, recipeScore:String(describing: recipeScrore), recipeCookingTime: (data.cookingTime)!, recipeDifficultyLevel: data.difficultyLevel!))
//            recipeCollectionView.reloadData()
//            print(searchedRecipe.first?.recipeScore)
//        } else {
//            print("Data is nil")
//        }
//    }

    private func configureSearchController(){
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Tarifinizi Bulun"
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

extension RecipeCategoryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UISearchResultsUpdating,UISearchBarDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if searching
//        {
//            return searchedRecipe.count
//        }
//        else
//        {
//            return recipeData.count
//        }
        return searchController.isActive ? viewModel.filteredData.count : viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        if searching
//        {
//            cell.recipeImage.image = UIImage(named: searchedRecipe[indexPath.row].recipeImage)
//            cell.recipeName.text = searchedRecipe[indexPath.row].recipeName
//            cell.recipeScore.text = searchedRecipe[indexPath.row].recipeScore
//            cell.recipeCookingTime.text = searchedRecipe[indexPath.row].recipeCookingTime
//            cell.recipeDifficultyLevel.text = searchedRecipe[indexPath.row].recipeDifficultyLevel
//            
//        }
//        else
//        {
//            
//            cell.recipeImage.image = UIImage(named: recipeData[indexPath.row].recipeImage)
//            cell.recipeName.text = recipeData[indexPath.row].recipeName
//            cell.recipeScore.text = recipeData[indexPath.row].recipeScore
//            cell.recipeCookingTime.text = recipeData[indexPath.row].recipeCookingTime
//            cell.recipeDifficultyLevel.text = recipeData[indexPath.row].recipeDifficultyLevel
//            
//        }
//        if(notFound){
//            if let imageURL = URL(string: searchedRecipe[indexPath.row].recipeImage) {
//                cell.recipeImage.kf.setImage(with: imageURL)
//            }
//            cell.recipeName.text = searchedRecipe[indexPath.row].recipeName
//            cell.recipeScore.text = searchedRecipe[indexPath.row].recipeScore
//            cell.recipeCookingTime.text = searchedRecipe[indexPath.row].recipeCookingTime
//            cell.recipeDifficultyLevel.text = searchedRecipe[indexPath.row].recipeDifficultyLevel
//            notFound = false
//        }
        let recipe: Recipe

        if searchController.isActive {
            recipe = viewModel.filteredData[indexPath.item]
        }
        else{
            recipe = viewModel.data[indexPath.item]
            
        }
        let cell = recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        as! RecipeCategoryDetailCollectionViewCell
        cell.configure(with: recipe)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 15

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (recipeCollectionView.frame.size.width - 20) / 2
        return CGSize(width: width, height:(recipeCollectionView.frame.size.width-93)/2)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.recipeCollectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
//        if searching
//        {
//            recipeVC.recipeName = searchedRecipe[indexPath.row].recipeName
//        }
//        else
//        {
//         
//            
//            recipeVC.recipeName = recipeData[indexPath.row].recipeName
//           
//        }
//
//        self.navigationController?.pushViewController(recipeVC, animated: true)
//        
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        let searchText = searchController.searchBar.text!
//        if !searchText.isEmpty
//        {
//         searching = true
//            searchedRecipe.removeAll()
//            for recipe in recipeData
//            {
//                if recipe.recipeName.lowercased().contains(searchText.lowercased())
//                {
//                    searchedRecipe.append(recipe)
//                }
//            }
//        }
//        else
//        {
//            searching = false
//            searchedRecipe.removeAll()
//            searchedRecipe = recipeData
//        }
        // Arama sorgusunu alın
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        if searchText.isEmpty {
            viewModel.filteredData = viewModel.data
        } else {
            // Verileri filtrele
            let filteredData = viewModel.data.filter { recipe in
                if let recipeName = recipe.recipeName {
                    return recipeName.lowercased().contains(searchText)
                } else {
                    return false
                }
            }

            viewModel.filteredData = filteredData
        }

        recipeCollectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        notFound = true
//        viewModel.fetchData(for: searchBar.text!)
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchedRecipe.removeAll()
//        recipeCollectionView.reloadData()
        
        guard let searchText = searchBar.text?.lowercased() else { return }

        let filteredData = viewModel.data.filter { recipe in
            if let recipeName = recipe.recipeName {
                return recipeName.lowercased().contains(searchText)
            } else {
                return false
            }
        }

        viewModel.filteredData = filteredData
        if filteredData.isEmpty {
            viewModel.endpoint = "/v1/recipes/search"
            viewModel.fetchData(for: ["foodName" : searchText])
        } else {
            recipeCollectionView.reloadData()
        }
        
    }
    
    
}
