import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let numberOfPeopleOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var selectedNumberOfPeople: String?
    var rotationAngle : CGFloat!
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        rotationAngle = -90*(.pi/180)
        pickerView.transform = CGAffineTransform(rotationAngle:rotationAngle)
        pickerView.frame = CGRect(x: 0, y: 70, width: view.frame.width, height: 100)
        
        view.addSubview(pickerView)
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfPeopleOptions.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberOfPeopleOptions[row]) Kişi"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumberOfPeople = numberOfPeopleOptions[row]
        // Seçilen kişi sayısını kullanarak işlemler yapabilirsiniz.
       
        print("Seçilen Kişi Sayısı: \(selectedNumberOfPeople ?? "")")
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.textAlignment = .center
        label.font = UIFont.systemFont (ofSize: 30)
        label.text = numberOfPeopleOptions[row]
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle:-rotationAngle)
        return view
    }
}
