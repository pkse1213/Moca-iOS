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
    let colors = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),]
    var selectedIndex = 1 {
        didSet { setUpImage() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerGesture()
    }
    
    private func setUpImage() {
        UIView.animate(withDuration: 0.2) {
            self.tutorialImageView.backgroundColor = self.colors[self.selectedIndex]
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
