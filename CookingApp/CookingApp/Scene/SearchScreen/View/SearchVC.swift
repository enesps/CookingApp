//
//  SearchVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//

import Foundation
import UIKit

class SearchVC:UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{

    private let searchSontroller = UISearchController(searchResultsController: nil)
    var tableView = UITableView()
    var data = ["Elma", "Armut", "Kiraz", "Muz", "Çilek", "Portakal", "Üzüm", "Ananas"]
    var filteredData: [String] = []
     override func viewDidLoad() {
         super.viewDidLoad()
         // TableView'ı konfigüre et
              tableView.frame = view.bounds
              tableView.dataSource = self
              view.addSubview(tableView)
         self.setupSearchController()

         // SearchBar'ı TableView'ın üstüne ekle
         tableView.tableHeaderView = searchSontroller.searchBar

         // Verileri TableView'a yükle
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         tableView.reloadData()

     }

    private func setupSearchController(){
        self.searchSontroller.searchResultsUpdater = self

        self.searchSontroller.searchBar.placeholder = "Yemek Tarifi Ara"
        
        
        self.navigationItem.searchController = searchSontroller
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
 
    // UISearchResultsUpdating metodu
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            // Verileri filtrele
            filteredData = data.filter { $0.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredData.count
        }
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item: String
        if isFiltering() {
            item = filteredData[indexPath.row]
        } else {
            item = data[indexPath.row]
        }
        cell.textLabel?.text = item
        return cell
    }
    // Arama yapılıp yapılmadığını kontrol etmek için yardımcı metot
    func isFiltering() -> Bool {
        return searchSontroller.isActive && !searchBarIsEmpty()
    }

    // SearchBar'ın boş olup olmadığını kontrol etmek için yardımcı metot
    func searchBarIsEmpty() -> Bool {
        return searchSontroller.searchBar.text?.isEmpty ?? true
    }
}

