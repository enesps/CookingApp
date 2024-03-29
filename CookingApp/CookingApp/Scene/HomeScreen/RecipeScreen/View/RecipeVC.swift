//
//  RecipeVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 28.11.2023.
//

import UIKit
import Combine
import Kingfisher
import SkeletonView
enum CellType {
    case recipeHeaderTableViewCell
    case recipeTime
    case recipeIngredientsTableViewCell
    case recipeCookingTableViewCell
//    case recipePickerPeopleTableViewCell
}
class RecipeVC: UIViewController {
    struct  recipeIngredients{
        var title:String
        var text:String
    }
    
    struct cellData{
        var sectionType:CellType
        var data:[Any]
    }

    let cellTypes: [CellType] = [.recipeHeaderTableViewCell,
                                 .recipeTime, .recipeIngredientsTableViewCell, .recipeCookingTableViewCell/*.recipePickerPeopleTableViewCell*/]
    

    @IBOutlet weak var recipeTableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = RecipeViewModel()
    var centerButtonsVisible = false
    var celldataArray  = [cellData]()
    var recipeId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        tableViewConfigure()
        viewModel.onSkeletonUpdate = { [weak self] isActive in
            if isActive {
                self?.recipeTableView.isSkeletonable = true
        //        recipeCollectionView.showAnimatedSkeleton(usingColor: .lightGray, animation: animation, transition: .crossDissolve(0.25))
                self?.recipeTableView.showAnimatedGradientSkeleton()
            } else {
                self?.recipeTableView.stopSkeletonAnimation()
                self?.view.hideSkeleton()
            }
        }
        dataUpdate()
        viewModel.fetchData(endpoint: "\(APIEndpoints.getRecipeById)\(recipeId ?? -1)")
    }
    func skeletonUpdate(){
        viewModel.onSkeletonUpdate = { [weak self] isActive in
            if isActive {
                self?.recipeTableView.isSkeletonable = true
                self?.recipeTableView.showAnimatedGradientSkeleton()
            }
            else {
                self?.recipeTableView.stopSkeletonAnimation()
                self?.view.hideSkeleton()
            }
        }
    }
    func headerOfTableView(){
        recipeTableView.separatorStyle = .none
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size.width))
        let imageView = UIImageView(frame: header.bounds)
        if viewModel.data?.imageURL != nil{
            imageView.kf.setImage(with: URL(string: viewModel.data?.imageURL ?? ""))
        }else{
            imageView.image = UIImage(base64String: viewModel.data?.image ?? "")
        }

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        header.addSubview(imageView)
        recipeTableView.tableHeaderView = header
    }
    func dataUpdate(){
        viewModel.onDataUpdate = { [weak self]   in
            self?.navigationItem.title = self?.viewModel.data?.recipeName
            self?.celldataArray.append(cellData(sectionType: .recipeHeaderTableViewCell, data: ["kjnsks"]))
            self?.celldataArray.append(cellData(sectionType: .recipeTime, data: [recipeTimer(cookingTime: self?.viewModel.data?.cookingTime, preparationTime: self?.viewModel.data?.preparationTime,servesFor: self?.viewModel.data?.servesFor)]))
            self?.celldataArray.append(cellData(sectionType: .recipeIngredientsTableViewCell, data: (self?.viewModel.data?.ingredients)!))
            self?.celldataArray.append(cellData(sectionType: .recipeCookingTableViewCell, data: (self?.viewModel.data?.instructions)!))
            self?.headerOfTableView()
            self?.recipeTableView.reloadData()

        }
    }
    func tableViewConfigure(){
        
        recipeTableView.delegate = self
         recipeTableView.dataSource = self
         recipeTableView.register(UINib(nibName: "RecipeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeHeaderTableViewCell")
         recipeTableView.register(UINib(nibName: "RecipeCookingTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCookingTableViewCell")
         recipeTableView.register(UINib(nibName: "RecipeIngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeIngredientsTableViewCell")
         recipeTableView.register(UINib(nibName: "RecipePickerPeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipePickerPeopleTableViewCell")
        recipeTableView.register(UINib(nibName: "RecipeCookingInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCookingInfoTableViewCell")
    }


}
extension RecipeVC : SkeletonTableViewDelegate,SkeletonTableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return celldataArray.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
            return "RecipeHeaderTableViewCell"

    }

//    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return celldataArray[section].data.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celldataArray[section].data.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = celldataArray[indexPath.section].sectionType
        switch cellType {
        case .recipeHeaderTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeHeaderTableViewCell", for: indexPath) as! RecipeHeaderTableViewCell
            cell.configure()
            return cell
        case .recipeIngredientsTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsTableViewCell", for: indexPath) as! RecipeIngredientsTableViewCell
            if let ingredientsData = celldataArray[indexPath.section].data[indexPath.row] as? Ingredient{
                cell.configure(with: ingredientsData)
                }
            return cell
        case .recipeCookingTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCookingTableViewCell", for: indexPath) as! RecipeCookingTableViewCell
            cell.recipeStepNumber.text = "\(indexPath.row+1)/\(celldataArray[indexPath.section].data.count)"
            if let instruction = celldataArray[indexPath.section].data[indexPath.row] as? Instruction {
                cell.configure(with: instruction)
                }
                return cell
        case .recipeTime:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCookingInfoTableViewCell", for: indexPath) as! RecipeCookingInfoTableViewCell
            if let recipeTime = celldataArray[indexPath.section].data[indexPath.row] as? recipeTimer {
                cell.config(with: recipeTime)
            }
            return cell
            
        }

    }

     func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = celldataArray[section].sectionType
        switch section{
            
       
        case .recipeIngredientsTableViewCell:
            return "Malzemeler:"
        case .recipeHeaderTableViewCell:
            
            return viewModel.data?.recipeName
        case .recipeCookingTableViewCell:
            return "Nasil Yapilir?"

        case .recipeTime:
            return ""
            
        }
    
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        if section != 0 && !centerButtonsVisible {
            centerButtonsVisible = true
            updateBarButtonItems()
        } else {
            centerButtonsVisible = false
            updateBarButtonItems()
        }
        
    }


    func updateBarButtonItems() {
        if centerButtonsVisible {
            // Eğer ikinci bölümdeysek, butonları ortalamak için bir boşluk ekleyeceğiz.
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            // Navigation bar için ortadaki butonlar
            let centerButton1 = UIBarButtonItem(title: "Button1", style: .plain, target: self, action: #selector(button1Tapped))
            let centerButton2 = UIBarButtonItem(title: "Button2", style: .plain, target: self, action: #selector(button2Tapped))

            // Butonları güncelliyoruz.
            navigationController?.setToolbarItems([flexibleSpace, centerButton1, flexibleSpace, centerButton2, flexibleSpace], animated: true)
        } else {
            // Eğer ikinci bölümde değilsek, varsayılan butonları ekliyoruz.
            let rightButton1 = UIBarButtonItem(title: "Button1", style: .plain, target: self, action: #selector(button1Tapped))
            let rightButton2 = UIBarButtonItem(title: "Button2", style: .plain, target: self, action: #selector(button2Tapped))
            
            navigationItem.rightBarButtonItems = [rightButton1, rightButton2]
            navigationItem.leftBarButtonItems = nil
        }
    }

    @objc func button1Tapped() {
        // Button 1'e tıklandığında yapılacak işlemler
    }

    @objc func button2Tapped() {
        // Button 2'ye tıklandığında yapılacak işlemler
    }
}


