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
import ALPopup

class RecipeVC: UIViewController {
    @IBOutlet weak var recipeTableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = RecipeViewModel()
    var celldataArray  = [cellData]()
    var recipeId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        tableViewConfigure()
        footerConfiguration()
        SkeletonUpdate()
        dataUpdate()
        viewModel.$statusCode
            .sink { statusCode in
                if let statusCode = statusCode {
                    if statusCode == 401{
                        let popupVC = ALPopup.popup(template: .init(
                            title: "Giriş Yapılmamış",
                            subtitle: "Lütfen Giriş Yapınız.",
                            privaryButtonTitle: "Giriş Yap")
                        )
                       
                        popupVC.tempateView.primaryButtonAction = {
                            popupVC.pop()
                            if let tabBarController = self.tabBarController {
                                tabBarController.selectedIndex = 4
                            }
                        }
                        popupVC.push(from: (self))
                    }
                }
            }
            .store(in: &cancellables)
        viewModel.fetchData1(endpoint: "\(APIEndpoints.getRecipeById)\(recipeId ?? -1)", idToken: KeyChainService.shared.readToken() ?? "")
    }
    
    private func SkeletonUpdate(){
        viewModel.onSkeletonUpdate = { [weak self] isActive in
            if isActive {
                self?.recipeTableView.isSkeletonable = true
                self?.recipeTableView.showAnimatedGradientSkeleton()
            } else {
                self?.recipeTableView.stopSkeletonAnimation()
                self?.view.hideSkeleton()
            }
        }
        
    }
    private func footerConfiguration(){
        // Footer view'i oluşturup ScrollView'e ekleyin
        let footerView = createFooterView()
        view.addSubview(footerView)
        
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 70) // Footer view'in yüksekliği
        ])
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
        let imageView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size.width))
        if viewModel.data?.imageURL != nil{
            imageView.imageView.kf.setImage(with: URL(string: viewModel.data?.imageURL ?? ""))
        }else{
            imageView.imageView.image = UIImage(base64String: viewModel.data?.image ?? "")
        }
 
       
        recipeTableView.tableHeaderView = imageView
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
    func createFooterView() -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        
        let button = UIButton()
        button.setTitle("Tarifi Yapmaya Başla!", for: .normal)
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.3269316852, blue: 0.4337471128, alpha: 1)
        button.layer.cornerRadius = 10 // Düğme kenarlarını yuvarlat
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10)
        ])
        
        return footerView
    }
    @objc func actionButton(){
//        guard let vc = self.storyboard?.instantiateViewController(identifier: "OnBoardingScreen") as? OnBoardingScreen else { return}
//        self.navigationController?.pushViewController(vc, animated: true)
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstructionOnBoardingVC") as? InstructionOnBoardingVC else { return }
        vc.ingredientsCount = viewModel.data?.instructions?.count ?? 1
        vc.ingredients = viewModel.data?.instructions
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
     
    
    
}
extension RecipeVC : SkeletonTableViewDelegate,SkeletonTableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return celldataArray.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RecipeHeaderTableViewCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celldataArray[section].data.count
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.recipeTableView.tableHeaderView as! StretchyTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = celldataArray[indexPath.section].sectionType
        switch cellType {
        case .recipeHeaderTableViewCell:
            let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeHeaderTableViewCell", for: indexPath) as! RecipeHeaderTableViewCell
            cell.recipeLikeBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            cell.recipeShareBtn.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
            cell.configure(with: viewModel.data!)
                
            
            
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
    @objc func buttonTapped() {
        viewModel.addLike(endpoint: "\(APIEndpoints.recipeLikeList)/\(recipeId ?? -1)", idToken: KeyChainService.shared.readToken() ?? "")
        
        }
    @objc func buttonTapped1() {
        viewModel.addLike(endpoint: "\(APIEndpoints.recipeSave)/\(recipeId ?? -1)", idToken: KeyChainService.shared.readToken() ?? "")
        
        }
}


