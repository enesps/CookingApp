//
//  ProfileNC.swift
//  CookingApp
//
//  Created by Enes Pusa on 24.11.2023.
//

import UIKit
import SPIndicator
class ProfileNC: UINavigationController {
 let flag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ana view controller'ı oluşturun (örneğin, bir ViewController sınıfı kullanın)
        if KeyChainService.shared.isTokenAvailable(){
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? UIViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            
            self.pushViewController(vc, animated: true)
        }else
        {

            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreLogin") as? UIViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            
            self.pushViewController(vc, animated: true)

        }
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Ana view controller'ı oluşturun (örneğin, bir ViewController sınıfı kullanın)
//        if KeyChainService.shared.isTokenAvailable(){
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? UIViewController else { return }
//            vc.modalPresentationStyle = .overFullScreen
//            
//            self.pushViewController(vc, animated: true)
//        }else
//        {
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreLogin") as? UIViewController else { return }
//            vc.modalPresentationStyle = .overFullScreen
//            
//            self.pushViewController(vc, animated: true)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
