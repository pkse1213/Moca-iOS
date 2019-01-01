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
    @IBOutlet var couponTableView: UITableView!
    @IBOutlet var navigationView: UIView!
    @IBOutlet var lineView: UIView!
    @IBOutlet var cautionView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.numberOfLines = 0
        infoLabel.text = "CC 멤버십 쿠폰 12개 적립 시, 아메리카노(R) 1잔 제공\n사용 할 카페의 아메리카노 가격을 기준으로 하며,\n무료 음료 쿠폰의 유효기간은 발행 일로부터 3개월\n쿠폰 사용시점에 제휴되어 있는 카페에서 교환 가능"
        
        setUpTableView()
        
        // status bar color change
        
    }
    
    private func setUpTableView() {
        couponTableView.delegate = self
        couponTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension MyPageCouponVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = couponTableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell", for: indexPath) as! CouponTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CouponAlertVC") as? CouponAlertVC {
            
            // 원래 코드
            self.addChild( vc )
            vc.view.frame = self.view.frame
            self.view.addSubview( vc.view )

            vc.didMove(toParent: self )
            // 원래 코드 여기까지
        }
    }
}
