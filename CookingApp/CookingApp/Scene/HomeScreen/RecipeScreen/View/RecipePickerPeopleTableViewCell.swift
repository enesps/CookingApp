////
////  RecipePickerPeopleTableViewCell.swift
////  CookingApp
////
////  Created by Enes Pusa on 8.12.2023.
////
//
//import UIKit
//
//class RecipePickerPeopleTableViewCell: UITableViewCell {
//    @IBOutlet weak var RecipePeoplepickerView: UIPickerView!
//    
//    var numberOfPeopleOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
//    var selectedNumberOfPeople: String?
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        RecipePeoplepickerView.dataSource = self
//        RecipePeoplepickerView.delegate = self
//        RecipePeoplepickerView.transform = CGAffineTransform(rotationAngle: -90*(.pi/180))
//        
//    }
//}
//
//extension RecipePickerPeopleTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return numberOfPeopleOptions.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(numberOfPeopleOptions[row]) Kişi"
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedNumberOfPeople = numberOfPeopleOptions[row]
//        print("Seçilen Kişi Sayısı: \(selectedNumberOfPeople ?? "")")
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 50
//    }
//
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 393
//    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        label.textAlignment = .center
//        label.font = UIFont.systemFont (ofSize: 15)
//        label.text = numberOfPeopleOptions[row]
//        view.addSubview(label)
//        view.transform = CGAffineTransform(rotationAngle:90*(.pi/180))
//        return view
//    }
//}
