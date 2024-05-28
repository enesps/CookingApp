//
//  RecipeLikedVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 29.11.2023.
//

import UIKit
import Combine
class RecipeLikeVC: UIViewController {
    let viewModel = RecipeSavedVM()
    var refreshControl = UIRefreshControl()
    private var cancellables: Set<AnyCancellable> = []
    struct recipeLike{
        var recipeImage:String
        var recipeName:String
    }
    var recipeLikeData = [recipeLike(recipeImage: "chicken", recipeName: "Tavuk"),
                          recipeLike(recipeImage: "chicken", recipeName: "Et"),
                          recipeLike(recipeImage: "chicken", recipeName: "Fasulye"),
                          recipeLike(recipeImage: "chicken", recipeName: "Sebze"),
                          recipeLike(recipeImage: "chicken", recipeName: "Dolma"),
                          recipeLike(recipeImage: "chicken", recipeName: "Manti")]
    @IBOutlet weak var recipeLikeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLikeTableView.dataSource = self
        recipeLikeTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        recipeLikeTableView.addSubview(refreshControl)
        viewModel.onDataUpdate = { [weak self] model, error in
            self?.recipeLikeTableView.reloadData()
        }
        
        viewModel.fetchData(idToken: KeyChainService.shared.readToken() ?? "")
        // Do any additional setup after loading the view.
    }
    @objc func refresh(){
        viewModel.fetchData(idToken: KeyChainService.shared.readToken() ?? "")
        self.refreshControl.endRefreshing()
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
extension RecipeLikeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeLikeTableView.dequeueReusableCell(withIdentifier: "RecipeLikeCell", for: indexPath) as! RecipeLikeTableViewCell
        if let imageURL = URL(string: viewModel.data?[indexPath.row].imageURL ?? "") {
            cell.recipeImage.kf.setImage(with: imageURL)
        }
        cell.recipeName.text = viewModel.data?[indexPath.row].recipeName
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        cell.recipeLike.isUserInteractionEnabled = true
        cell.recipeLike.tag = indexPath.row // Save the row index as a tag to identify which image was tapped
        cell.recipeLike.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = self.storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as! RecipeVC

            recipeVC.recipeId = viewModel.data?[indexPath.row].id
        self.navigationController?.pushViewController(recipeVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {

            if let cell = tappedImageView.superview?.superview as? RecipeLikeTableViewCell {
                if let indexPath = recipeLikeTableView.indexPath(for: cell) {
                    viewModel.data?.remove(at: indexPath.row)
                    recipeLikeTableView.reloadData()
                }
            }
        }
        
        
    }
}
