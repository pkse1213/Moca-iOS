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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
}

extension MyPageVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            if let myPageInfoCell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageInfoCell", for: indexPath) as? MyPageInfoCell {
                cell = myPageInfoCell
            }
        }
        else if indexPath.row == 1 {
            if let likeCafeCell = myPageTableView.dequeueReusableCell(withIdentifier: "LikeCafeCell", for: indexPath) as? LikeCafeCell {
                likeCafeCell.navigationbarController = self.navigationController
                cell = likeCafeCell
            }
        }
        else if indexPath.row == 2 {
            if let myPageCell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as? MyPageCell {
                let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))

                myPageCell.addGestureRecognizer(moreBtnTapGestureRecognizer)
                
                cell = myPageCell
            }
        }
        else {
            if let membershipCell = myPageTableView.dequeueReusableCell(withIdentifier: "MembershipCell", for: indexPath) as? MembershipCell {
                
                membershipCell.parentVC = self
                membershipCell.unit = unit
                
                cell = membershipCell
            }
        }
        
        return cell
    }
}
