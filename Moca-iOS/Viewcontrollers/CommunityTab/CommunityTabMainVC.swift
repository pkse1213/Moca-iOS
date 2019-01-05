//
//  CommunityTabMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityTabMainVC: UIViewController {
    let selectMenus = ["내 피드", "소셜 피드"]
    var selectIndex = 0 {
        didSet {
            changeFeedKind()
        }
    }
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectFeedView: UIView!
    @IBOutlet weak var feedMenuTableView: UITableView!
   
    // 상단 프로필 뷰
    @IBOutlet weak var profileBackgroundView: UIView!
    @IBOutlet weak var profileSquareView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    
    // 피드 테이블 뷰
    @IBOutlet weak var communityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpView() {
        selectFeedView.isHidden = true
        
        feedMenuTableView.delegate = self
        feedMenuTableView.dataSource = self
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
        profileImageView.applyRadius(radius: 24)
        profileSquareView.applyRadius(radius: 3)
        profileSquareView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    
    private func changeFeedKind() {
        feedMenuTableView.reloadData()
        dropUpandDropDown()
    }
    
    private func dropUpandDropDown() {
        UIView.animate(withDuration: 0.5) {
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
    
    @IBAction func goToSearch(_ sender: Any) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunitySearchVC") as? CommunitySearchVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension CommunityTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == feedMenuTableView {
            return 2
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == communityTableView {
            if let feedCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                feedCell.navigationController = self.navigationController
                cell = feedCell
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
