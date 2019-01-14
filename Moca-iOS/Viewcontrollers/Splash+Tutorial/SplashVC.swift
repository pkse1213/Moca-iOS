//
//  SplashVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 12..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit
import Lottie
import Hero

class SplashVC: UIViewController {

    @IBOutlet var splashView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSplash()
        
    }
    
    private func setUpSplash() {
        let animationView = LOTAnimationView(name: "iosSplash")
        
        animationView.frame = splashView.frame
        self.splashView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        let bottom = animationView.bottomAnchor.constraint(equalTo: splashView.bottomAnchor)
        let top = animationView.topAnchor.constraint(equalTo: splashView.topAnchor)
        let leading = animationView.leadingAnchor.constraint(equalTo: splashView.leadingAnchor)
        let trailing = animationView.trailingAnchor.constraint(equalTo: splashView.trailingAnchor)
        splashView.addConstraints([top, bottom, leading, trailing])
        
        animationView.play{ (finished) in
            guard let dvc = UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: "TutorialVC")  as? TutorialVC else { return }
            dvc.hero.isEnabled = true
            dvc.hero.modalAnimationType = HeroDefaultAnimationType.zoom
            self.present(dvc, animated: true)
        }
    }

}
