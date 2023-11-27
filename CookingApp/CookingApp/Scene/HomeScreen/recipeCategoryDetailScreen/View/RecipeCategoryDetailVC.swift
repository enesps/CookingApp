//
//  RecipeCategoryDetailVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.11.2023.
//

import UIKit

class RecipeCategoryDetailVC: UIViewController {
    var searching = false
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
        
        recipeFillData()
        configureSearchController()
        // Do any additional setup after loading the view.
    }
    func recipeFillData(){
        let recipeItem1 = RecipeModel(recipeImage: "chicken", recipeName: "Ana yemek", recipeScore: "4.5", recipeCookingTime: "50dk", recipeDifficultyLevel: "Orta")
        let recipeItem2 = RecipeModel(recipeImage: "chicken", recipeName: "Icecek", recipeScore: "5.0", recipeCookingTime: "30dk", recipeDifficultyLevel: "kolay")
        let recipeItem3 = RecipeModel(recipeImage: "chicken", recipeName: "Tatli", recipeScore: "3.5", recipeCookingTime: "60dk", recipeDifficultyLevel: "Zor")
        let recipeItem4 = RecipeModel(recipeImage: "chicken", recipeName: "Corba", recipeScore: "4.99", recipeCookingTime: "35dk", recipeDifficultyLevel: "Zor")
        recipeData.append(recipeItem1)
        recipeData.append(recipeItem2)
        recipeData.append(recipeItem3)
        recipeData.append(recipeItem4)
        
    }
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

extension RecipeCategoryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UISearchResultsUpdating,UISearchBarDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching
        {
            return searchedRecipe.count
        }
        else
        {
            return recipeData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        as! RecipeCategoryDetailCollectionViewCell
        if searching
        {
            cell.recipeImage.image = UIImage(named: searchedRecipe[indexPath.row].recipeImage)
            cell.recipeName.text = searchedRecipe[indexPath.row].recipeName
            cell.recipeScore.text = searchedRecipe[indexPath.row].recipeScore
            cell.recipeCookingTime.text = searchedRecipe[indexPath.row].recipeCookingTime
            cell.recipeDifficultyLevel.text = searchedRecipe[indexPath.row].recipeDifficultyLevel
            
        }
        else
        {
            
            cell.recipeImage.image = UIImage(named: recipeData[indexPath.row].recipeImage)
            cell.recipeName.text = recipeData[indexPath.row].recipeName
            cell.recipeScore.text = recipeData[indexPath.row].recipeScore
            cell.recipeCookingTime.text = recipeData[indexPath.row].recipeCookingTime
            cell.recipeDifficultyLevel.text = recipeData[indexPath.row].recipeDifficultyLevel
            
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty
        {
         searching = true
            searchedRecipe.removeAll()
            for recipe in recipeData
            {
                if recipe.recipeName.lowercased().contains(searchText.lowercased())
                {
                    searchedRecipe.append(recipe)
                }
            }
        }
        else
        {
            searching = false
            searchedRecipe.removeAll()
            searchedRecipe = recipeData
        }
        recipeCollectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedRecipe.removeAll()
        recipeCollectionView.reloadData()
    }
    
    
}
