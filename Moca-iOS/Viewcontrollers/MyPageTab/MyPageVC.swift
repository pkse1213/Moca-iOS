//
//  MyPageVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 29..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    var unit : CGFloat = 0
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var myData = MyPageData(userId: "a", userName: "a", userPhone: "01000000000", userImgUrl: nil, userStatusComment: "a", auth: false, follow: false)
    
    var scrapCafeList : [ScrapCafeData]? {
        didSet { myPageTableView.reloadData() }
    }
    
    var couponList : [CouponData]? {
        didSet { myPageTableView.reloadData() }
    }
    
    var membershipList : [MembershipData]? {
        didSet { myPageTableView.reloadData() }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 통신
        getMyPageData()
        getLikeCafeData()
        getCouponData()
        getMembershipData()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        setUpTableView()
        
        myPageTableView.estimatedRowHeight = 293
        myPageTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }
    
    // 카페명 검색 결과 설정 - 최신 리뷰 설정하기 위해
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        unit = self.view.frame.width/375
    }
    
    @objc func moreAction(_:UIImageView) {
        if let vc = UIStoryboard(name: "MyPageTab", bundle: nil).instantiateViewController(withIdentifier: "MyPageCouponVC") as? MyPageCouponVC {
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func profileModifyAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "MyPageTab", bundle: nil).instantiateViewController(withIdentifier: "ProfileModifyVC") as? ProfileModifyVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 통신
    // 마이페이지 회원 조회
    private func getMyPageData() {
        MyPageCheckService.shared.getMyPageData(token: token, user_id: "coco", completion: { (myPageData) in
            self.myData = myPageData
        }) { (errCode) in
            print("회원 정보 조회에 실패했습니다.")
        }
    }
    
    // 찜한 카페 조회
    private func getLikeCafeData() {
        MyPageScrapService.shared.getScrap(token: token, completion: { (scrapCafeList) in
            self.scrapCafeList = scrapCafeList
        }) { (errCode) in
            print("찜한 카페 조회에 실패 || \(errCode)")
        }
    }
    
    // 음료 쿠폰
    private func getCouponData() {
        MyPageCouponService.shared.getCouponList(token: token, completion: { (couponList) in
            self.couponList = couponList
        }) { (errCode) in
            print("음료 쿠폰 조회 실패 || \(errCode)")
        }
    }
    
    // 멤버십
    private func getMembershipData() {
        MyPageMembershipService.shared.getMembership(token: token, completion: { (membershipDataList) in
            self.membershipList = membershipDataList
        }) { (errCode) in
            print("멤버쉽 리스트 조회 실패 || \(errCode)")
        }
    }
}

extension MyPageVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            if let myPageInfoCell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageInfoCell", for: indexPath) as? MyPageInfoCell {
                
                myPageInfoCell.profileImageView.imageFromUrl(myData.userImgUrl, defaultImgPath: "")
                myPageInfoCell.nameLabel.text = myData.userName
                myPageInfoCell.messageLabel.text = myData.userStatusComment
                
                cell = myPageInfoCell
            }
        }
        else if indexPath.row == 1 {
            if let likeCafeCell = myPageTableView.dequeueReusableCell(withIdentifier: "LikeCafeCell", for: indexPath) as? LikeCafeCell {
                likeCafeCell.navigationbarController = self.navigationController
                
                likeCafeCell.scrapCafeList = self.scrapCafeList
                
                cell = likeCafeCell
            }
        }
        else if indexPath.row == 2 {
            if let myPageCell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as? MyPageCell {
                let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))

                myPageCell.addGestureRecognizer(moreBtnTapGestureRecognizer)
                
                if let couponCount = couponList?.count {
                    myPageCell.numberLabel.text = String(couponCount)
                }
                
                
                cell = myPageCell
            }
        }
        else {
            if let membershipCell = myPageTableView.dequeueReusableCell(withIdentifier: "MembershipCell", for: indexPath) as? MembershipCell {
                
                membershipCell.parentVC = self
                membershipCell.membershipList = self.membershipList
                
                cell = membershipCell
            }
        }
        
        return cell
    }
}
