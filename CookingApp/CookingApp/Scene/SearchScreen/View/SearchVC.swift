//
//  SearchVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//

import Foundation
import UIKit

class SearchVC:UIViewController{

    @IBOutlet weak var recipeSearchTableView: UITableView!
    var searching = false
    var searchedRecipe = [RecipeSearchModel]()
    
    var searchController = UISearchController(searchResultsController: nil)
    var categoryTitle : String?
    var recipeData = [RecipeSearchModel]()
    //    private let searchSontroller = UISearchController(searchResultsController: nil)
//    var tableView = UITableView()
//    var data = ["Elma", "Armut", "Kiraz", "Muz", "Çilek", "Portakal", "Üzüm", "Ananas"]
//    var filteredData: [String] = []
     override func viewDidLoad() {
         super.viewDidLoad()
         recipeSearchTableView.dataSource = self
         recipeSearchTableView.delegate = self
         recipeSearchTableView.register(UINib(nibName: "RecipeCardTableViewCell", bundle: nil), forCellReuseIdentifier: "XibCard")
         recipeFillData()
         configureSearchController()
     }
    func recipeFillData(){
        let recipeItem1 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Ana yemek", recipeScore: "4.5", recipeCookingTime: "50dk", recipeDifficultyLevel: "Orta")
        let recipeItem2 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Icecek", recipeScore: "5.0", recipeCookingTime: "30dk", recipeDifficultyLevel: "kolay")
        let recipeItem3 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Tatli", recipeScore: "3.5", recipeCookingTime: "60dk", recipeDifficultyLevel: "Zor")
        let recipeItem4 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Corba", recipeScore: "4.99", recipeCookingTime: "35dk", recipeDifficultyLevel: "Zor")
        let recipeItem5 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Sarma", recipeScore: "4.5", recipeCookingTime: "50dk", recipeDifficultyLevel: "Orta")
        let recipeItem6 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Sucuk", recipeScore: "5.0", recipeCookingTime: "30dk", recipeDifficultyLevel: "kolay")
        let recipeItem7 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Et", recipeScore: "3.5", recipeCookingTime: "60dk", recipeDifficultyLevel: "Zor")
        let recipeItem8 = RecipeSearchModel(recipeImage: "chicken", recipeName: "Pilav", recipeScore: "4.99", recipeCookingTime: "35dk", recipeDifficultyLevel: "Zor")
        recipeData.append(recipeItem1)
        recipeData.append(recipeItem2)
        recipeData.append(recipeItem3)
        recipeData.append(recipeItem4)
        recipeData.append(recipeItem5)
        recipeData.append(recipeItem6)
        recipeData.append(recipeItem7)
        recipeData.append(recipeItem8)
        
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

//    private func setupSearchController(){
//        self.searchSontroller.searchResultsUpdater = self
//
//        self.searchSontroller.searchBar.placeholder = "Yemek Tarifi Ara"
//        
//        
//        self.navigationItem.searchController = searchSontroller
//        self.definesPresentationContext = false
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//    }
 
//    // UISearchResultsUpdating metodu
//    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            // Verileri filtrele
//            filteredData = data.filter { $0.lowercased().contains(searchText.lowercased()) }
//            tableView.reloadData()
//        }
//    }
    
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredData.count
//        }
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let item: String
//        if isFiltering() {
//            item = filteredData[indexPath.row]
//        } else {
//            item = data[indexPath.row]
//        }
//        cell.textLabel?.text = item
//        return cell
//    }
//    // Arama yapılıp yapılmadığını kontrol etmek için yardımcı metot
//    func isFiltering() -> Bool {
//        return searchSontroller.isActive && !searchBarIsEmpty()
//    }
//
//    // SearchBar'ın boş olup olmadığını kontrol etmek için yardımcı metot
//    func searchBarIsEmpty() -> Bool {
//        return searchSontroller.searchBar.text?.isEmpty ?? true
//    }
}


extension SearchVC: UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return searchedRecipe.count
        }
        else
        {
            return recipeData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeSearchTableView.dequeueReusableCell(withIdentifier: "XibCard", for: indexPath)
        as! RecipeCardTableViewCell
        if searching
        {
            cell.recipeCardImage.image = UIImage(named: searchedRecipe[indexPath.row].recipeImage)
            cell.recipeCardName.text = searchedRecipe[indexPath.row].recipeName
            cell.recipeCardScore.text = searchedRecipe[indexPath.row].recipeScore
            cell.recipeCardCookingTime.text = searchedRecipe[indexPath.row].recipeCookingTime
            cell.recipeCardDifficultyLevel.text = searchedRecipe[indexPath.row].recipeDifficultyLevel
            
        }
        else
        {
            
            cell.recipeCardImage.image = UIImage(named: recipeData[indexPath.row].recipeImage)
            cell.recipeCardName.text = recipeData[indexPath.row].recipeName
            cell.recipeCardScore.text = recipeData[indexPath.row].recipeScore
            cell.recipeCardCookingTime.text = recipeData[indexPath.row].recipeCookingTime
            cell.recipeCardDifficultyLevel.text = recipeData[indexPath.row].recipeDifficultyLevel
            
        }
//        cell.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.3
//        
//     
//
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.darkGray.cgColor
//        cell.layer.cornerRadius = 15
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC
//        if searching
//        {
//            recipeVC.recipeId = searchedRecipe[indexPath.row].recipeName
//        }
//        else
//        {
//         
//            
//            recipeVC.recipeId = recipeData[indexPath.row].id
//           
//        }
//
//        self.navigationController?.pushViewController(recipeVC, animated: true)
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
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
        recipeSearchTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedRecipe.removeAll()
        recipeSearchTableView.reloadData()
        
    }
    
    
}
