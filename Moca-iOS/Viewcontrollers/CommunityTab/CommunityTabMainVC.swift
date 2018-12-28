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
    @IBOutlet weak var selectFeedView: UIView!
    @IBOutlet weak var feedMenuTableView: UITableView!
    
    @IBOutlet weak var communityTableView: UITableView!
    @IBOutlet weak var profileBackgroundView: UIView!
    @IBOutlet weak var profileSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        feedMenuTableView.delegate = self
        feedMenuTableView.dataSource = self
        
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
        profileSquareView.applyRadius(radius: 3)
        profileSquareView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    
    func changeFeedKind() {
        feedMenuTableView.reloadData()
        selectFeedView.isHidden = !selectFeedView.isHidden
    }
    
    @IBAction func chooseFeedKindAction(_ sender: Any) {
        selectFeedView.isHidden = !selectFeedView.isHidden
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
        if tableView == communityTableView {
            if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityContentVC") as? CommunityContentVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if tableView == feedMenuTableView {
            selectIndex = indexPath.row
        }
    }
}
