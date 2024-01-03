//
//  AddRecipeDetailVC.swift
//  CookingApp
//
//  Created by Enes Pusa on 2.01.2024.
//

import UIKit

class AddRecipeDetailVC: UIViewController {
    
    @IBOutlet weak var addRecipeTableView: UITableView!
    var sections = ["Malzemeler", "Nasıl Yapılır","Submit Button"]
    var  IngredientViewCount = 1
    var InstructionViewCount = 1
    var tableHeaderView: UIView!
    var headerImageView: UIImageView!
    var materialTextFields: [UITextField] = []
    var howToTextFields: [UITextField] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecipeTableView.delegate = self
        addRecipeTableView.dataSource = self
        addRecipeTableView.register(UINib(nibName: "InstructionViewCell", bundle: nil), forCellReuseIdentifier: "InstructionCell")
        addRecipeTableView.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        addRecipeTableView.register(UINib(nibName: "AddButtonRecipeViewCell", bundle: nil), forCellReuseIdentifier: "AddButtonCell")
        
        
        // Table Header View oluştur
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: addRecipeTableView.frame.width, height: addRecipeTableView.frame.width))
        
        headerImageView = UIImageView(frame: tableHeaderView.bounds)
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.image = UIImage(named: "chicken") // Varsayılan bir görüntü ekleyebilirsiniz.
        tableHeaderView.addSubview(headerImageView)
        
        // Görüntüye tıklama işlemini eklemek için bir GestureRecognizer oluştur
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerImageTapped))
        headerImageView.isUserInteractionEnabled = true
        headerImageView.addGestureRecognizer(tapGesture)
        
        // Table Header View'i tableView'a ayarla
        addRecipeTableView.tableHeaderView = tableHeaderView
        // Malzeme Ekle butonu
        let addIngredientButton = UIBarButtonItem(title: "Malzeme Ekle", style: .plain, target: self, action: #selector(addIngredientView))
        addIngredientButton.image = UIImage(systemName: "add")
        // Nasıl Yapılır Ekle butonu
        let addInstructionButton = UIBarButtonItem(title: "Nasil Yapilir Ekle", style: .plain, target: self, action: #selector(addInstructionView))
        
        // Navigation Item'a butonları ekle
        navigationItem.rightBarButtonItems = [addIngredientButton, addInstructionButton]
        
    }
    @objc func addIngredientView() {
        // Malzeme eklemek için bir view cell ekleyin
        IngredientViewCount += 1
        
        // Eklenen view cell'i içeren IndexPath'i hesaplayın
        let newMaterialIndexPath = IndexPath(row: IngredientViewCount - 1, section: 0)
        
        // TableView'a yeni view cell'i ekleyin
        addRecipeTableView.insertRows(at: [newMaterialIndexPath], with: .automatic)
    }
    @objc func addInstructionView() {
        // Malzeme eklemek için bir view cell ekleyin
        InstructionViewCount += 1
        
        let newMaterialIndexPath = IndexPath(row: InstructionViewCount - 1, section: 1)
        
        // TableView'a yeni view cell'i ekleyin
        addRecipeTableView.insertRows(at: [newMaterialIndexPath], with: .automatic)
        
    }
    @objc func headerImageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension AddRecipeDetailVC:UITableViewDelegate ,UIImagePickerControllerDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            headerImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return IngredientViewCount
        } else if section == 1 {
            return InstructionViewCount // "Nasıl Yapılır" section'ı için sadece bir view cell
        }
        else if section == 2{
            return 1
        }
        return 0
    }
    // Her view cell için içeriği belirtin
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)  as! IngredientCell
            // Hücredeki text field'ın delegate'ini ayarla
            cell.ingredient.delegate = self
            cell.amount.delegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath)  as! InstructionViewCell
            // Hücredeki text field'ın delegate'ini ayarla
            cell.instruction.delegate = self
            return cell
            
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell", for: indexPath)  as! AddButtonRecipeViewCell
            cell.addRecipeButton.setImage(UIImage(systemName: "square.and.arrow.up")
                                          , for: .normal)
            cell.addRecipeButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
            return cell
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Sadece 1. ve 2. section'ındaki satırları düzenle
        return indexPath.section == 0 || indexPath.section == 1
    }
    
    // TableView'de bir satır silindiğinde çağrılan fonksiyon
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                // "Malzemeler" section'ında silme işlemi gerçekleştirildiğinde
                
                
                tableView.beginUpdates()
                IngredientViewCount -= 1
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            } else if indexPath.section == 1 {
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
    @objc func submitButtonTapped() {
        // Access the text from all text fields in sections 0 and 1
        var allMaterialTexts: [String] = []
        for i in 0..<IngredientViewCount {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? IngredientCell {
                allMaterialTexts.append(cell.ingredient.text ?? "")
                allMaterialTexts.append(cell.amount.text ?? "")
            }
        }
        
        var allHowToTexts: [String] = []
        for i in 0..<InstructionViewCount {
            let indexPath = IndexPath(row: i, section: 1)
            if let cell = addRecipeTableView.cellForRow(at: indexPath) as? InstructionViewCell {
                allHowToTexts.append(cell.instruction.text ?? "")
            }
        }
        // Now you have the text from all text fields, you can use them as needed
        print("All Material Texts: \(allMaterialTexts)")
        print("All How To Texts: \(allHowToTexts)")
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
    // Verilen bir view'in hangi hücrede olduğunu bulan yardımcı fonksiyon
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
