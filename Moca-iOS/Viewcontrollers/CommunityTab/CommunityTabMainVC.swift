//
//  CommunityTabMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityTabMainVC: UIViewController {
    
    @IBOutlet var searchBarButtonItem: UIBarButtonItem!
    
    // 피드 종류 선택
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectFeedView: UIView!
    @IBOutlet weak var feedMenuTableView: UITableView!
   
    // 피드 테이블 뷰
    let selectMenus = ["소셜 피드", "내 피드"]
    @IBOutlet weak var communityTableView: UITableView!
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var selectIndex = 0 {
        didSet {
            changeFeedKind()
            initReviewData()
        }
    }
    
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
        initReviewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func test(_ sender: Any) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityUserFeedVC") as? CommunityUserFeedVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func initUserData() {
        CommunityUserService.shareInstance.getUser(userId: "-1", token: token, completion: { (res) in
            self.user = res
            print("내 프로필 성공")
        }) { (err) in
            print("내 프로필 실패")
        }
    }
    
    private func initReviewData() {
        switch selectIndex {
        case 0:
            CommunityReviewService.shareInstance.getSocialReview(token: token, completion: { (res) in
                self.reviews = res
                print("소셜 피드 성공")
            }) { (err) in
                print("소셜 피드 실패")
            }
        case 1:
            CommunityReviewService.shareInstance.getUserReview(userId: "-1", token: token, completion: { (res) in
                self.reviews = res
                print("내 피드 성공")
            }) { (err) in
                print("내 피드 실패")
            }
        default:
            return
        }
    }
    
    private func setUpView() {
        selectFeedView.isHidden = true
        
        feedMenuTableView.delegate = self
        feedMenuTableView.dataSource = self
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }
    
    private func changeFeedKind() {
        dropUpandDropDown()
        feedMenuTableView.reloadData()
    }
    
    private func dropUpandDropDown() {
        UIView.animate(withDuration: 0.3) {
            self.selectFeedView.isHidden = !self.selectFeedView.isHidden
            
            if self.tableViewTopConstraint.constant == 0 {
                self.tableViewTopConstraint.constant = -100
            } else {
                self.tableViewTopConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func chooseFeedKindAction(_ sender: Any) {
        dropUpandDropDown()
    }
    
    @IBAction func profileButtonAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityReviewWrittingVC") as? CommunityReviewWrittingVC {
            self.present(vc, animated: true)
        }
    }
}

extension CommunityTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == feedMenuTableView {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == feedMenuTableView {
            return 2
        } else {
            if section == 0 {
                return selectIndex
            } else {
                guard let reviews = reviews else { return 0 }
                return reviews.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == communityTableView {
//            guard let reviews = reviews, let user = user else { return cell }
            if indexPath.section == 0 {
                guard let user = user else { return cell }
                if let userCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityUserProfileCell") as? CommunityUserProfileCell {
                    userCell.user = user
                    cell = userCell
                }
            } else if indexPath.section == 1 {
                guard let reviews = reviews else { return cell }
                if let feedCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                    feedCell.review = reviews[indexPath.row]
                    feedCell.delegate = self
                    cell = feedCell
                }
            }
            
        } else if tableView == feedMenuTableView {
            if let selectCell = feedMenuTableView.dequeueReusableCell(withIdentifier: "CommunitySelectFeedCell") as? CommunitySelectFeedCell {
                selectCell.feedNameLabel.text = selectMenus[indexPath.row]
                if indexPath.row != selectIndex {
                    selectCell.choosedImageView.isHidden = true
                } else {
                    selectCell.choosedImageView.isHidden = false
                }
                cell = selectCell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == feedMenuTableView {
            selectIndex = indexPath.row
        }
    }
}

extension CommunityTabMainVC: ListViewCellDelegate {
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "게시글 신고", style: .default, handler: { result in
            //doSomething
        }))
        actionSheet.addAction(UIAlertAction(title: "사용자 신고", style: .default, handler: { result in
            //doSomething
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
            
    }
    
}
