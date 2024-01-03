//
//  AddRecipeNC.swift
//  CookingApp
//
//  Created by Enes Pusa on 3.01.2024.
//

import UIKit

class AddRecipeNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Ana view controller'ı oluşturun (örneğin, bir ViewController sınıfı kullanın)


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        if KeyChainService.shared.isTokenAvailable(){
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRecipeVC") as? AddRecipeVC else { return }
            vc.modalPresentationStyle = .overFullScreen
            
            self.pushViewController(vc, animated: true)
        }else
        {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRecipeVC") as? AddRecipeVC else { return }
            vc.modalPresentationStyle = .overFullScreen
            
            self.pushViewController(vc, animated: true)
            let alertController = UIAlertController(title: "Giris Yapiniz", message: "Tarif eklemek istiyorsaniz Giris Yapiniz!", preferredStyle: .alert)

            let action = UIAlertAction(title: "Giris Yap", style: .default) { (action) in
                if let tabBarController = self.tabBarController {
                    tabBarController.selectedIndex = 4
                }
            }

            alertController.addAction(action)

            present(alertController, animated: true, completion: nil)

        }
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
