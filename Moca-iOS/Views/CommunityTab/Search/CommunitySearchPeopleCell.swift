//
//  CommunitySearchPeopleTableViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class CommunitySearchPeopleCell: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    var user: SearchUser? {
        didSet { setUpData() }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    override func awakeFromNib() {
        super.awakeFromNib()

        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

    
    private func setUpData() {
        guard let user = user else { return }
        nameLabel.text = user.userName
        statusLabel.text = user.userStatusComment ?? ""
        profileImage.imageFromUrl(user.userImgURL, defaultImgPath: "commonDefaultimage")
        switch user.followIs {
        case true:
            followButton.setImage(#imageLiteral(resourceName: "communityFollowinglistFollow.png"), for: .normal)
        case false:
            followButton.setImage(#imageLiteral(resourceName: "communityFollowinglistFollowing.png"), for: .normal)
        default:
            return
        }
    }
    
    @IBAction func followAction(_ sender: UIButton) {
        guard let user = user else { return }
        CommunityFollowService.shareInstance.postFollow(userId: user.userID, token: token, completion: { (message) in
            if sender.currentImage == #imageLiteral(resourceName: "communityFollowinglistFollow.png") {
                self.followButton.setImage(#imageLiteral(resourceName: "communityFollowinglistFollowing.png"), for: .normal)
            } else {
                self.followButton.setImage(#imageLiteral(resourceName: "communityFollowinglistFollow.png"), for: .normal)
            }
        }) { (err) in
            print("팔로우/언팔로우 실패 \(err)")
        }
    }
}
