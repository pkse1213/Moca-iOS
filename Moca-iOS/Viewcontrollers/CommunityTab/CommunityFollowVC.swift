//
//  CommunityFollowVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityFollowVC: UIViewController {
    @IBOutlet weak var followTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var followUsers: [FollowUser]? {
        didSet { followTableView.reloadData() }
    }
    var userId = "first"
    var path = "following"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initFollowData()
        if path == "following" {
            self.navigationItem.title = "팔로잉"
        } else {
            self.navigationItem.title = "팔로워"
        }
    }
    
    private func setUpTableView() {
        followTableView.delegate = self
        followTableView.dataSource = self
    }
    
    private func initFollowData() {
        CommunityFollowUserService.shareInstance.getFollowUser(userId: userId, token: token, path: path, completion: { (res) in
            self.followUsers = res
            print("팔로잉/팔로우 조회 성공")
        }) { (err) in
            self.followUsers = []
            print("팔로잉/팔로우 조회 실패")
        }
    }
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil
        )
    }
}

extension CommunityFollowVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let followUsers = followUsers else { return 0 }
        if followUsers.count == 0 {
            return 1
        } else {
             return followUsers.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let followUser = followUsers else { return cell }
        if followUser.count == 0 {
            if let emptyCell = followTableView.dequeueReusableCell(withIdentifier: "CommunityEmptyCell") as? CommunityEmptyCell {
                if path == "follower" {
                    emptyCell.messageLabel.text = "팔로워가 없습니다"
                } else if path == "following" {
                    emptyCell.messageLabel.text = "팔로잉한 유저가 없습니다"
                }
                cell = emptyCell
            }
        } else {
            if let followCell = followTableView.dequeueReusableCell(withIdentifier: "CommunityFollowCell") as? CommunityFollowCell {
                followCell.followUser = followUser[indexPath.row]
                cell = followCell
            }
        }
        
        return cell
    }
    
}
