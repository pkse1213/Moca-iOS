//
//  PopularCollectionViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 04/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    @IBOutlet var popularView: UIView!
    @IBOutlet var popularPofileImage: UIImageView!
    @IBOutlet var popularNameLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    var user: BestUser? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        popularPofileImage.layer.borderWidth = 0.3
        popularPofileImage.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        popularPofileImage.layer.masksToBounds = false
        popularPofileImage.layer.cornerRadius = popularPofileImage.frame.height/2
        popularPofileImage.clipsToBounds = true
        
        popularView.layer.borderWidth = 0.3
        popularView.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        popularView.layer.masksToBounds = false
        popularView.layer.cornerRadius = 5.0
        popularView.clipsToBounds = true
    }
    
    private func setUpData() {
        guard let user = user else { return }
        popularNameLabel.text = user.userName
        popularPofileImage.imageFromUrl(user.userImgURL, defaultImgPath: "commonDefaultimage")
        
        switch user.follow {
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
