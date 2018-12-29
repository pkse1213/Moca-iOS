//
//  MyPageCouponVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MyPageCouponVC: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.numberOfLines = 0
        infoLabel.text = "CC 멤버십 쿠폰 12개 적립 시, 아메리카노(R) 1잔 제공\n사용 할 카페의 아메리카노 가격을 기준으로 하며,\n무료 음료 쿠폰의 유효기간은 발행 일로부터 3개월\n쿠폰 사용시점에 제휴되어 있는 카페에서 교환 가능"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
}
