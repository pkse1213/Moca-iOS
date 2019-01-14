//
//  CategoryUserCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 7..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CommunityUserProfileCell: UITableViewCell {
    // 상단 프로필 뷰
    @IBOutlet weak var profileSquareView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMessageLabel: UILabel!
    @IBOutlet weak var contentCntLabel: UILabel!
    @IBOutlet weak var followerCntLabel: UIButton!
    @IBOutlet weak var follingCntLabel: UIButton!
    var follow = true
    var followCnt = 0 {
        didSet { followerCntLabel.setTitle("\(followCnt)", for: .normal) }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var user: CommunityUser? {
        didSet { setUpData() }
    }
    var delegate: ListViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    @IBAction func followAction(_ sender: UIButton) {
        guard let user = user else { return }
        CommunityFollowService.shareInstance.postFollow(userId: user.userID, token: token, completion: { (String) in
            self.follow = !self.follow
            
            if self.follow {
                self.profileButton.setImage(#imageLiteral(resourceName: "communityOtheruserFriend"), for: .normal)
                self.followCnt = self.followCnt + 1
            } else {
                self.profileButton.setImage(#imageLiteral(resourceName: "communityOtheruserFollow"), for: .normal)
                self.followCnt = self.followCnt - 1
            }
        }) { (err) in
            print("팔로우/ 언팔로우 실패\(err)")
        }
    }
    private func setUpData() {
        guard let user = user else { return }
        userNameLabel.text = user.userName
        userMessageLabel.text = user.userStatusComment
        contentCntLabel.text = "\(user.reviewCount)"
        follingCntLabel.setTitle("\(user.followingCount)", for: .normal)
        followCnt = user.followerCount
        follow = user.follow
        profileImageView.imageFromUrl(user.userImgURL, defaultImgPath: "commonDefaultimage")
        if user.follow {
            profileButton.setImage(#imageLiteral(resourceName: "communityOtheruserFriend"), for: .normal)
        } else {
            profileButton.setImage(#imageLiteral(resourceName: "communityOtheruserFollow"), for: .normal)
        }
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 24)
        profileSquareView.applyRadius(radius: 3)
        profileSquareView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
}
