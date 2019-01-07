//
//  CommunityTabMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityTabMainVC: UIViewController {
    let selectMenus = ["소셜 피드", "내 피드"]
    var selectIndex = 0 {
        didSet {
            changeFeedKind()
        }
    }
    // 피드 종류 선택
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectFeedView: UIView!
    @IBOutlet weak var feedMenuTableView: UITableView!
   
    // 피드 테이블 뷰
    @IBOutlet weak var communityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpView() {
        selectFeedView.isHidden = true
        
        feedMenuTableView.delegate = self
        feedMenuTableView.dataSource = self
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
    }
    
    private func changeFeedKind() {
        communityTableView.reloadData()
        feedMenuTableView.reloadData()
        dropUpandDropDown()
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
    
    @IBAction func goToSearch(_ sender: Any) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunitySearchVC") as? CommunitySearchVC {
            self.navigationController?.pushViewController(vc, animated: true)
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
                return 9
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == communityTableView {
            if indexPath.section == 0 {
                if let userCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityUserProfileCell") as? CommunityUserProfileCell {
                    
                    cell = userCell
                }
            } else if indexPath.section == 1 {
                if let feedCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                    feedCell.navigationController = self.navigationController
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
