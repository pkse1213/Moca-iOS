//
//  Unwind.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 29..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class Unwind: UIStoryboardSegue {
    override func perform()
    {
        //ViewContoroller
        let src = self.source        //LeftViewController
        let dst = self.destination
        
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        // LeftViewController 초기 위치
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        // ViewController 초기 위치
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width/3, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
            // LeftViewController 이동할 위치
            
            src.view.transform = CGAffineTransform(translationX: src.view.frame.width, y: 0)
            // ViewController 이동할 위치
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {
            finished in src.dismiss(animated: false, completion: nil)
        })
        
    }
}
