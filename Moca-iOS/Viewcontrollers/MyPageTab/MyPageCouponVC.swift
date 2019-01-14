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
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var dataList : [CouponData]? {
        didSet { couponTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.numberOfLines = 0
        infoLabel.text = "CC 멤버십 쿠폰 12개 적립 시, 아메리카노(R) 1잔 제공\n사용 할 카페의 아메리카노 가격을 기준으로 하며,\n무료 음료 쿠폰의 유효기간은 발행 일로부터 3개월\n쿠폰 사용시점에 제휴되어 있는 카페에서 교환 가능"
        
        getLikeCafeData()
        
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
    
    // 통신
    private func getLikeCafeData() {
        MyPageCouponService.shared.getCouponList(token: token, completion: { (couponDataList) in
            self.dataList = couponDataList
        }) { (errCode) in
            print("쿠폰 조회 실패")
        }
    }
}

extension MyPageCouponVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataList = dataList else { return 0 }
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = couponTableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell", for: indexPath) as! CouponTableViewCell
        
        cell.dateLabel.text = "\(String(describing: dataList?[indexPath.row].couponId))"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CouponAlertVC") as? CouponAlertVC {
            
            // 원래 코드
            self.addChild( vc )
            vc.view.frame = self.view.frame
            
            if let number = Int((dataList?[indexPath.row].couponAuthenticationNumber)!) {
                
                let firstNum = Int(number / 1000)
                
                vc.label1.text = "\(firstNum)"
                
                let secondNum = Int((number - firstNum * 1000) / 100)
                
                vc.label2.text = "\(secondNum)"
                
                let thirdNum = Int((number - firstNum * 1000 - secondNum * 100) / 10)
                
                vc.label3.text = "\(thirdNum)"
                
                let firthNum = number - firstNum * 1000 - secondNum * 100 - thirdNum * 10
                
                vc.label4.text = "\(firthNum)"
            }
            
            self.view.addSubview( vc.view )

            vc.didMove(toParent: self )
            // 원래 코드 여기까지
        }
    }
}
