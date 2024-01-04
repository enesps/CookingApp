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
    var recipe: AddRecipeModel = AddRecipeModel()
    var tableHeaderView: UIView!
    var headerImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
//        // Menü düğmesini oluştur
//                let menuButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonTapped))
//
//                // UIMenuItem'ları oluştur
//                let menuItem1 = UIAction(title: "Option 1", handler: { _ in
//                    print("Option 1 selected")
//                })
//
//                let menuItem2 = UIAction(title: "Option 2", handler: { _ in
//                    print("Option 2 selected")
//                })
//
//                // UIMenu oluştur
//                let menu = UIMenu(title: "Menu", children: [menuItem1, menuItem2])
//
//                // UIBarButtonItem'a UIMenu'yu ata
//                menuButton.menu = menu
//
//                // UINavigationBar'ın sağında yer alan item'ı ayarla
//                navigationItem.rightBarButtonItem = menuButton
//        let addIngredientButton = UIBarButtonItem(title: "Malzeme Ekle", style: .plain, target: self, action: #selector(addIngredientView))
//        addIngredientButton.image = UIImage(systemName: "add")
//        let addInstructionButton = UIBarButtonItem(title: "Nasil Yapilir Ekle", style: .plain, target: self, action: #selector(addInstructionView))
//        navigationItem.rightBarButtonItems = [addIngredientButton, addInstructionButton]
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
    
    @objc private func menuButtonTapped() {
        // Bu fonksiyonu dilediğiniz gibi özelleştirebilirsiniz
        print("Menu Button Tapped!")
    }
    
    @objc func addIngredientView() {
        IngredientViewCount += 1
        let newMaterialIndexPath = IndexPath(row: IngredientViewCount - 1, section: 1)
        addRecipeTableView.insertRows(at: [newMaterialIndexPath], with: .automatic)
    }
    @objc func addInstructionView() {
        InstructionViewCount += 1
        let newMaterialIndexPath = IndexPath(row: InstructionViewCount - 1, section: 2)
        addRecipeTableView.insertRows(at: [newMaterialIndexPath], with: .automatic)
    }
    @objc func headerImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @objc func submitButtonTapped() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = addRecipeTableView.cellForRow(at: indexPath) as? HeaderSetViewCell {
            recipe.category = cell.category.text
            recipe.recipeName = cell.recipeName.text
            recipe.preparationTime = cell.prepearingTime.text
            recipe.cookingTime = cell.cookingTime.text
            recipe.servesFor = cell.servesFor.text
            
        }
        var IngredientViewTexts: [AddIngredient] = []
        for i in 0..<IngredientViewCount {
            let indexPath = IndexPath(row: i, section: 1)
            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? IngredientCell {
                IngredientViewTexts.append(AddIngredient(ingredient:cell.ingredient.text ?? "" , amount: cell.amount.text ?? ""))
                recipe.ingredients?.append(AddIngredient(ingredient:cell.ingredient.text ?? "" , amount: cell.amount.text ?? ""))
                print(recipe.ingredients?[i].ingredient)
            }
        }
        print("IngredientViewTexts before setting: \(IngredientViewTexts)")
        recipe.ingredients = IngredientViewTexts
        print("Ingredients after setting: \(recipe.ingredients)")
        var InstructionViewTexts: [AddInstruction] = []
        for i in 0..<InstructionViewCount {
            let indexPath = IndexPath(row: i, section: 2)
            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? InstructionViewCell {
                InstructionViewTexts.append(AddInstruction(instruction: cell.instruction.text ?? "", time: nil))
            }
        }
        recipe.instructions = InstructionViewTexts
        if let ingredients = recipe.ingredients {
            if let firstIngredient = ingredients.first {
                print("Recipe Ingredient: \(firstIngredient)")
            } else {
                print("No ingredients added.")
            }
        } else {
            print("No ingredients added.")
        }
        print("All IngredientView Texts: \(IngredientViewTexts)")
        print("All InstructionViewTexts Texts: \(InstructionViewTexts)")
    }
}
extension AddRecipeDetailVC:UITableViewDelegate ,UIImagePickerControllerDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            headerImageView.image = pickedImage
            //ui image to base 64 convert
            
            
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
            return  IngredientViewCount// "Nasıl Yapılır" section'ı için sadece bir view cell
        }
        else if section == 2{
            return InstructionViewCount
        }else if section == 3{
            return 1
        }
        return 0
    }
    // Her view cell için içeriği belirtin
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)  as! HeaderSetViewCell
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)  as! IngredientCell
            // Hücredeki text field'ın delegate'ini ayarla
            cell.ingredient.delegate = self
            cell.amount.delegate = self
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath)  as! InstructionViewCell
            cell.instruction.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell", for: indexPath)  as! AddButtonRecipeViewCell
            cell.addRecipeButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
            return cell
        }
    }
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let indexPath = findIndexPathForView(textField) {
            // Eğer text field bir hücre içindeyse
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            
            if let nextCell = addRecipeTableView.cellForRow(at: nextIndexPath) as? IngredientCell {
                // Eğer bir sonraki hücre varsa, onun text field'ına odaklan
                nextCell.ingredient.becomeFirstResponder()
            } else {
                // Eğer bir sonraki hücre yoksa, klavyeyi kapat
                textField.resignFirstResponder()
            }
        }
        return true
    }
    private func findIndexPathForView(_ view: UIView) -> IndexPath? {
        var currentView: UIView? = view
        while currentView != nil {
            if let cell = currentView as? UITableViewCell {
                return addRecipeTableView.indexPath(for: cell)
            }
            currentView = currentView?.superview
        }
        return nil
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
