//
//  LaunchScreen.swift
//  CookingApp
//
//  Created by Enes Pusa on 16.11.2023.
//

import Foundation
import UIKit
import Lottie

class LaunchScreen:UIViewController{
    override func viewDidLoad() {
        if !isAppAlreadyLaunched() {
            // İlk indirme sonrasında gösterilecek ViewController'ı göster
            showFirstTimeViewController()
            // Gösterim durumunu kaydet
            setAppAlreadyLaunched()
        } else {
            // Gösterilmişse normal akışa devam et
        }
        super.viewDidLoad()
        let animationView = LottieAnimationView(name: "LottieAnimation")
           animationView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(animationView)
        NSLayoutConstraint.activate([
              animationView.topAnchor.constraint(equalTo: view.topAnchor),
              animationView.leftAnchor.constraint(equalTo: view.leftAnchor),
              animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
              animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])

            animationView.loopMode = .loop
            animationView.play()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isAppAlreadyLaunched() {
            // İlk indirme sonrasında gösterilecek ViewController'ı göster
            showFirstTimeViewController()
            // Gösterim durumunu kaydet
            setAppAlreadyLaunched()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
                guard let self = self else { return }
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else { return }
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }

    }
    func setAppAlreadyLaunched() {
        UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunched")
    }

    func isAppAlreadyLaunched() -> Bool {
        return UserDefaults.standard.bool(forKey: "isAppAlreadyLaunched")
    }
    func showFirstTimeViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
            guard let self = self else { return }
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingScreen") as? UIViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
