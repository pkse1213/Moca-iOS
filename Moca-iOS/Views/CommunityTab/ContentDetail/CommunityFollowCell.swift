//
//  CommunityFollwCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityFollowCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var followUser: FollowUser? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    @IBAction func followAction(_ sender: UIButton) {
        guard let followUser = followUser else { return }
        CommunityFollowService.shareInstance.postFollow(userId: followUser.userID, token: token, completion: { (res) in
            print("팔로우/언팔로우 성공")
            if sender.currentImage == #imageLiteral(resourceName: "communityFollowinglistFollow") {
                self.followButton.setImage(#imageLiteral(resourceName: "communityFollowing"), for: .normal)
            } else if sender.currentImage == #imageLiteral(resourceName: "communityFollowing") {
                self.followButton.setImage(#imageLiteral(resourceName: "communityFollowinglistFollow"), for: .normal)
            }
        }) { (err) in
            print("팔로우/언팔로우 실패")
        }
    }
    
    private func setUpData() {
        guard let user = followUser else { return }
        nameLabel.text = user.userName
        if user.follow {
            followButton.setImage(#imageLiteral(resourceName: "communityFollowinglistFollow"), for: .normal)
        } else {
            followButton.setImage(#imageLiteral(resourceName: "communityFollowing"), for: .normal)
        }
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 23)
    }
}
