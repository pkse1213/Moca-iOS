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
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var followUsers: [FollowUser]? {
        didSet { followTableView.reloadData() }
    }
    var userId = "first"
    var path = "following"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initFollowData()
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
        return followUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let followUser = followUsers?[indexPath.row] else { return cell }
        if let followCell = followTableView.dequeueReusableCell(withIdentifier: "CommunityFollowCell") as? CommunityFollowCell {
            followCell.followUser = followUser
            cell = followCell
        }
        return cell
    }
    
}
