//
//  AddRecipeDetailVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 2.01.2024.
//

import UIKit
import Combine
class AddRecipeDetailVC: UIViewController {

    
    
    @IBOutlet weak var addRecipeTableView: UITableView!
    var sections = ["Yemek ismi","Malzemeler", "Nasıl Yapılır",""]
    var  IngredientViewCount = 1
    var InstructionViewCount = 1
    var ingredientArray = [AddIngredient()]
    var instructionArray = [AddInstruction()]
    var tableHeaderView: UIView!
    var headerImageView: UIImageView!
    let viewModel = AddRecipeDetailVM()
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataUpdate = { [weak self]   in
            self?.navigationController?.dismiss(animated: true)
        }
        setUpTableView()
        setUpTableViewHeader()
        setUpNavigationBarButtons()
    }
    
    func setUpTableView(){
        addRecipeTableView.delegate = self
        addRecipeTableView.dataSource = self
        addRecipeTableView.separatorStyle = .none
        addRecipeTableView.register(UINib(nibName: "InstructionViewCell", bundle: nil), forCellReuseIdentifier: "InstructionCell")
        addRecipeTableView.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        addRecipeTableView.register(UINib(nibName: "AddButtonRecipeViewCell", bundle: nil), forCellReuseIdentifier: "AddButtonCell")
        addRecipeTableView.register(UINib(nibName: "HeaderSetViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
    }
    
    func setUpTableViewHeader(){
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: addRecipeTableView.frame.width, height: addRecipeTableView.frame.width))
        
        headerImageView = UIImageView(frame: tableHeaderView.bounds)
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.image = UIImage(named: "chicken")
        tableHeaderView.addSubview(headerImageView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerImageTapped))
        headerImageView.isUserInteractionEnabled = true
        headerImageView.addGestureRecognizer(tapGesture)
        addRecipeTableView.tableHeaderView = tableHeaderView
    }
    
    func setUpNavigationBarButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem:  .add, primaryAction: nil, menu:menuItems())
    }
    func menuItems () -> UIMenu {
    let addMenuItems = UIMenu(title: "",options: .displayInline, children: [
        UIAction (title: " Fotograf Sec", image: UIImage (systemName: "photo.circle" )) { (_) in
            self.headerImageTapped()
        },
        UIAction (title: "Malzeme Ekle", image: UIImage(systemName: "plus.circle")) { (_) in
            self.addIngredientView()
        },
    
        UIAction (title: "Tarif Ekle", image: UIImage (systemName: "plus.circle")) { (_) in
            self.addInstructionView()
        },
])
        return addMenuItems
    }

    
    @objc func addIngredientView() {
//        IngredientViewCount += 1
//        let newMaterialIndexPath = IndexPath(row: IngredientViewCount - 1, section: 1)
//        addRecipeTableView.insertRows(at: [newMaterialIndexPath], with: .automatic)
        ingredientArray.append(AddIngredient())
        addRecipeTableView.reloadData()
    }
    @objc func addInstructionView() {
        instructionArray.append(AddInstruction())
        addRecipeTableView.reloadData()
    }
    @objc func headerImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @objc func submitButtonTapped() {
        print(ingredientArray.count)

        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = addRecipeTableView.cellForRow(at: indexPath) as? HeaderSetViewCell {
//            viewModel.requestModel.category = cell.categoryButton.currentTitle
//            viewModel.requestModel.recipeName = cell.recipeName.text
//            viewModel.requestModel.preparationTime = cell.prepearingTimeButton.currentTitle
//            viewModel.requestModel.cookingTime = cell.cookingTimeButton.currentTitle
//            viewModel.requestModel.servesFor = cell.servesForButton.currentTitle
//            viewModel.updateRequestModel()
            viewModel.requestModel.recipeName = cell.recipeName.text
            viewModel.requestModel.category = cell.category.text
            viewModel.requestModel.servesFor = cell.servesFor.text
            viewModel.requestModel.preparationTime = cell.prepearingTime.text
            viewModel.requestModel.cookingTime = cell.cookingTime.text
            

        }
        viewModel.requestModel.ingredients = ingredientArray
        viewModel.requestModel.instructions = instructionArray
        viewModel.updateRequestModel()
        print(viewModel.requestModel)
//        for (index,value) in ingredientArray.enumerated() {
//            let indexPath = IndexPath(row: index, section: 1)
//            
//            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? IngredientCell {
//                cell.ingredient.text = value.ingredient
//                cell.amount.text = value.amount
//    
//                print("ingredient:" + (cell.ingredient.text ?? ""))
//                print("amount:" + (cell.amount.text ?? ""))
//
//
//            }
//        }
        for (index,value) in instructionArray.enumerated() {
            let indexPath = IndexPath(row: index, section: 2)
            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? InstructionViewCell {
                cell.instruction.text = value.instruction
                
//                IngredientViewTexts.append(AddIngredient(ingredient:cell.ingredient.text ?? "" , amount: cell.amount.text ?? ""))
                print("instruction:" + (cell.instruction.text ?? ""))
               


            }
        }
//        viewModel.requestModel.ingredients = IngredientViewTexts
//        viewModel.updateRequestModel()
//        var InstructionViewTexts: [AddInstruction] = []
//        for i in 0..<InstructionViewCount {
//            let indexPath = IndexPath(row: i, section: 2)
//            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? InstructionViewCell {
//                InstructionViewTexts.append(AddInstruction(instruction: cell.instruction.text ?? "", time: nil))
//                print(cell.instruction.text)
//            }
//        }
//
//        viewModel.requestModel.instructions = InstructionViewTexts
////        viewModel.requestModel.imageUrl = "fejkvfdjkdfkl"
//        viewModel.updateRequestModel()
//        
//        print(viewModel.requestModel.ingredients)
//        print(viewModel.requestModel.instructions)
//        viewModel.performTokenAuth(idToken: KeyChainService.shared.readToken() ?? "")
////        print(viewModel.requestModel)
    }
}
extension AddRecipeDetailVC:UITableViewDelegate ,UIImagePickerControllerDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            headerImageView.image = pickedImage
                if let base64String = pickedImage.toBase64() {
                    viewModel.requestModel.image = base64String
                    viewModel.updateRequestModel()
//                    viewModel.requestModel.imageUrl = "fejkvfdjkdfkl"
                }
            }
            
            
        picker.dismiss(animated: true, completion: nil)
        }
        
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return  ingredientArray.count// "Nasıl Yapılır" section'ı için sadece bir view cell
        }
        else if section == 2{
            return instructionArray.count
        }else if section == 3{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)  as! HeaderSetViewCell
            viewModel.requestModel.recipeName = cell.recipeName.text
            viewModel.requestModel.category = cell.category.text
            viewModel.requestModel.servesFor = cell.servesFor.text
            viewModel.requestModel.preparationTime = cell.prepearingTime.text
            viewModel.requestModel.cookingTime = cell.cookingTime.text
            cell.ingredientUpdate = { [weak self] recipeName,categoryButton, servesForButton, prepearingTimeButton,cookingTimeButton in
                self?.viewModel.requestModel.recipeName = recipeName
                self?.viewModel.requestModel.category = categoryButton
                self?.viewModel.requestModel.servesFor = servesForButton
                self?.viewModel.requestModel.preparationTime = prepearingTimeButton
                self?.viewModel.requestModel.cookingTime = cookingTimeButton
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
            cell.ingredient.text = ingredientArray[indexPath.row].ingredient
            cell.amount.text = ingredientArray[indexPath.row].amount
            cell.ingredientUpdate = { [weak self] ingredient, amount in
                self?.ingredientArray[indexPath.row] = AddIngredient(ingredient: ingredient, amount: amount)
                self?.viewModel.requestModel.ingredients?[indexPath.row] = AddIngredient(ingredient: ingredient, amount: amount)
                
            }
            return cell
            }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath)  as! InstructionViewCell
            cell.instruction.text = instructionArray[indexPath.row].instruction
            cell.instructionUpdate = { [weak self] instruction in
                self?.instructionArray[indexPath.row] = AddInstruction(instruction: instruction,time: nil)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell", for: indexPath)  as! AddButtonRecipeViewCell
            cell.addRecipeButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
            return cell
        }
    }
//    func configureCell(_ cell: IngredientCell, at indexPath: IndexPath) {
//        let ingredient = ingredientArray[indexPath.row]
//
//        cell.textFieldValueChanged = { ingredientText, amountText in
//            // Handle text changes
//            self.ingredientArray[indexPath.row].ingredient = ingredientText
//            self.ingredientArray[indexPath.row].amount = amountText
//            // You can perform validation or any other actions here
//        }
//
//        cell.ingredient.text = ingredient.ingredient
//        cell.amount.text = ingredient.amount
//    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Sadece 1. ve 2. section'ındaki satırları düzenle
        return indexPath.section == 1 || indexPath.section == 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Hücreye tıklanıldığında hiçbir şey yapma
        addRecipeTableView.deselectRow(at: indexPath, animated: true)
    }
    // TableView'de bir satır silindiğinde çağrılan fonksiyon
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 1 {
                // "Malzemeler" section'ında silme işlemi gerçekleştirildiğinde
                
                
                tableView.beginUpdates()
                IngredientViewCount -= 1
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            } else if indexPath.section == 2 {
                tableView.beginUpdates()
                InstructionViewCount -= 1
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
                // "Nasıl Yapılır" section'ında başka bir işlem yapabilirsiniz, eğer gerekirse
            }
        }
    }
    
    // Her section için başlık belirtin
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}

extension UIImage {
    
    // UIImage'i Base64 formatına dönüştüren fonksiyon
    func toBase64() -> String? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    // Base64 formatındaki bir string'i kullanarak UIImage oluşturan fonksiyon
    convenience init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            return nil
        }
        self.init(data: data)
    }

}
