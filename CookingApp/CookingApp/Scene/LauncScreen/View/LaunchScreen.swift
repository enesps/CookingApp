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
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
            guard let self = self else { return }
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingScreen") as? UIViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
