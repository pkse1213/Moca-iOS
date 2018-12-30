//
//  CouponAlertVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CouponAlertVC: UIViewController {

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var alertView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        alertView.applyRadius(radius: 5.0)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
