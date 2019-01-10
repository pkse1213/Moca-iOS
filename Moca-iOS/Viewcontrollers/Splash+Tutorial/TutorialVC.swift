//
//  TutorialVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {

    
    @IBOutlet var tutorialImageView: UIImageView!
    var selectedIndex = 1 {
        didSet { setUpImage() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerGesture()
    }
    
    private func setUpImage() {
        UIView.animate(withDuration: 0.2) {
            self.tutorialImageView.backgroundColor = UIImage(named: "\(tutorial\(selectedIndex))")
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
            if selectedIndex != 0 {
                selectedIndex = selectedIndex - 1
            }
        case UISwipeGestureRecognizer.Direction.left:
            if selectedIndex != 4 {
                selectedIndex = selectedIndex + 1
            }
        default:
            break
        }
    }
}
