//
//  HeaderSetViewCell.swift
//  CookingApp
//
//  Created by Enes Pusa on 4.01.2024.
//

import UIKit

class HeaderSetViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {

    @IBOutlet weak var category: UITextField!
    
    @IBOutlet weak var servesFor: UITextField!
    @IBOutlet weak var prepearingTime: UITextField!
    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var cookingTime: UITextField!
    
    let categoryPickerView = UIPickerView()
    let servesPickerView = UIPickerView()
    let CookingPickerView = UIPickerView()
    let preaperingPickerView = UIPickerView()

    let categories = ["Çorba", "Ana Yemek", "Tatlı", "İçecek"]
    let servesData = Array(1...30)
    let timeHoursData = Array(0...23)
    let timeMinutesData = Array(0...59)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupPickers()
    }

    func setupPickers() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        servesPickerView.delegate = self
        servesPickerView.dataSource = self
        CookingPickerView.delegate = self
        CookingPickerView.dataSource = self
        preaperingPickerView.delegate = self
        preaperingPickerView.dataSource = self

        category.inputView = categoryPickerView
        servesFor.inputView = servesPickerView
        prepearingTime.inputView = preaperingPickerView
        cookingTime.inputView = CookingPickerView
        category.inputAccessoryView = createToolbar(for: category)
        servesFor.inputAccessoryView = createToolbar(for: servesFor)
        prepearingTime.inputAccessoryView = createToolbar(for: prepearingTime)
        cookingTime.inputAccessoryView = createToolbar(for: cookingTime)

        // İsterseniz inputAccessoryView kullanarak picker üzerinde bir toolbar ekleyebilirsiniz.
        // Örnek: category.inputAccessoryView = createToolbar()
    }
    func createToolbar(for textField: UITextField) -> UIToolbar {
         let toolbar = UIToolbar()
         toolbar.sizeToFit()

         let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(doneButtonTapped))
         let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

         toolbar.setItems([flexibleSpace, doneButton], animated: false)

         // TextField'a atanmış olan inputAccessoryView'e ekleyerek görüntülenmesini sağlar.
         textField.inputAccessoryView = toolbar

         return toolbar
     }

     @objc func doneButtonTapped() {
         // Tamam butonuna tıklandığında keyboard ve picker'ı kapatma işlemi
         endEditing(true)
     }

    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == CookingPickerView || pickerView == preaperingPickerView {
            return 2 // Saat ve dakika için iki component
        } else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPickerView {
            return categories.count
        } else if pickerView == servesPickerView {
            return servesData.count
        } else {
            return component == 0 ? timeHoursData.count : timeMinutesData.count
        }
    }

    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView {
            return categories[row]
        } else if pickerView == servesPickerView {
            return "\(servesData[row])"
        } else {
            return component == 0 ? "\(timeHoursData[row]) Saat" : "\(timeMinutesData[row]) Dakika"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            category.text = categories[row]
        } else if pickerView == servesPickerView {
            servesFor.text = "\(servesData[row])"
        } else if pickerView == preaperingPickerView {
            let selectedHour = preaperingPickerView.selectedRow(inComponent: 0)
            let selectedMinute = preaperingPickerView.selectedRow(inComponent: 1)
            prepearingTime.text = "\(timeHoursData[selectedHour]) Saat \(timeMinutesData[selectedMinute]) Dakika"
           
        }else{
            let selectedHour = CookingPickerView.selectedRow(inComponent: 0)
            let selectedMinute = CookingPickerView.selectedRow(inComponent: 1)
            cookingTime.text = "\(timeHoursData[selectedHour]) Saat \(timeMinutesData[selectedMinute]) Dakika"

        }
    }
}
