//
//  RecipeSavedVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit
import Combine
class RecipeSavedVC: UIViewController {
    @IBOutlet weak var recipeSavedTableView: UITableView!
    let viewModel = RecipeSavedVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeSavedTableView.delegate = self
        recipeSavedTableView.dataSource = self
        
        recipeSavedTableView.register(UINib(nibName: "RecipeCardTableViewCell", bundle: nil), forCellReuseIdentifier: "XibCard")
        viewModel.onDataUpdate = { [weak self] model, error in
            self?.recipeSavedTableView.reloadData()
        }
        
        viewModel.fetchData(idToken: KeyChainService.shared.readToken() ?? "")
    }
}
extension RecipeSavedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeSavedTableView.dequeueReusableCell(withIdentifier: "XibCard", for: indexPath) as! RecipeCardTableViewCell
        cell.configure(with: viewModel.data![indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            recipeSavedTableView.beginUpdates()
            viewModel.data?.remove(at: indexPath.row)
            recipeSavedTableView.deleteRows(at: [indexPath], with: .fade)
            recipeSavedTableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC

            recipeVC.recipeId = viewModel.data?[indexPath.row].id
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}
