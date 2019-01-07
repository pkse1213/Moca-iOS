//
//  CommunityUserFeedVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CommunityUserFeedVC: UIViewController {
    @IBOutlet weak var communityTableView: UITableView!
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var userId = ""
    var user: CommunityUser? {
        didSet { communityTableView.reloadData() }
    }
    var reviews: [CommunityReview]? {
        didSet { communityTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func initUserData() {
        CommunityUserService.shareInstance.getUser(userId: userId, token: token, completion: { (res) in
            self.user = res
            self.title = res.userName
            print("유저 프로필 성공")
        }) { (err) in
            print("유저 프로필 실패")
        }
    }
    
    private func initReviewData() {
        CommunityReviewService.shareInstance.getUserReview(userId: userId, token: token, completion: { (res) in
            self.reviews = res
            print("유저 피드 성공")
        }) { (err) in
            print("유저 피드 실패")
        }
    }
    
    private func setUpView() {
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }
    
    @IBAction func profileButtonAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityReviewWrittingVC") as? CommunityReviewWrittingVC {
            self.present(vc, animated: true)
        }
    }
    
}

extension CommunityUserFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reviews = reviews, let _ = user else { return 0 }
        if section == 0 {
            return 1
        } else {
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let reviews = reviews, let user = user else { return cell }

        if indexPath.section == 0 {
            if let userCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityUserProfileCell") as? CommunityUserProfileCell {
                userCell.user = user
                cell = userCell
            }
        } else if indexPath.section == 1 {
            if let feedCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                feedCell.review = reviews[indexPath.row]
                cell = feedCell
            }
        }
        
        return cell
    }
}
