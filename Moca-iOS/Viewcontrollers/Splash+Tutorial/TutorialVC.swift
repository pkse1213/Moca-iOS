//
//  TutorialVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {

    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var tutorialImageView: UIImageView!
    var selectedIndex = 1 {
        didSet { setUpImage() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.applyRadius(radius: 15)
        startButton.isHidden = true
//        startButton.applyBorder(width: 0.7, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        registerGesture()
    }
    
    private func setUpImage() {
        UIView.animate(withDuration: 0.2) {
            self.tutorialImageView.image = UIImage(named: "tutorial\(self.selectedIndex)")
            self.view.layoutIfNeeded()
        }
    }
    
    private func registerGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(holeSwiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.tutorialImageView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(holeSwiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.tutorialImageView.addGestureRecognizer(swipeLeft)
    }
    
    @objc func holeSwiped(gesture: UISwipeGestureRecognizer)
    {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            if selectedIndex != 1 {
                selectedIndex = selectedIndex - 1
            }
        case UISwipeGestureRecognizer.Direction.left:
            if selectedIndex != 4 {
                selectedIndex = selectedIndex + 1
            }
        default:
            break
        }
        if selectedIndex == 4 {
            startButton.isHidden = false
        } else {
            startButton.isHidden = true
        }
    }
}
