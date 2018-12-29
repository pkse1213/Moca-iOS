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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        setUpTableView()
    }
    
    private func setUpTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }
}

extension MyPageVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageInfoCell", for: indexPath) as! MyPageInfoCell
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell = myPageTableView.dequeueReusableCell(withIdentifier: "LikeCafeCell", for: indexPath) as! LikeCafeCell
            
            return cell
        }
        else if indexPath.row == 2 {
            let cell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as! MyPageCell
            
            return cell
        }
        else {
            let cell = myPageTableView.dequeueReusableCell(withIdentifier: "MembershipCell", for: indexPath) as! MembershipCell
            
            return cell
        }
    }
}
