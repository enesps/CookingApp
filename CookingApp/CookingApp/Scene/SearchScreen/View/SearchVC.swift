//
//  SearchVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 20.11.2023.
//

import Foundation
import UIKit

class SearchVC:UIViewController, UISearchBarDelegate{
    var searchBar: UISearchBar!

     override func viewDidLoad() {
         super.viewDidLoad()

         // Arama çubuğunu oluştur
         searchBar = UISearchBar()
         searchBar.delegate = self
         searchBar.placeholder = "Ara..."
         searchBar.searchBarStyle = .minimal  // İhtiyacınıza bağlı olarak searchBar stilini ayarlayabilirsiniz.

         // Arama çubuğunun yüksekliğini ayarla
         searchBar.frame = CGRect(x: 10, y: 100, width: 370, height: 150)
         

         // Arama çubuğunu görüntüye ekle
         view.addSubview(searchBar)
     }

     // UISearchBarDelegate fonksiyonları buraya eklenebilir

     // Örneğin:
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         print("Arama butonuna tıklandı.")
        
     }
 }
