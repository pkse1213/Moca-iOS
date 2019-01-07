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
    @IBOutlet weak var followerCntLabel: UILabel!
    @IBOutlet weak var follingCntLabel: UILabel!
    
    var user: CommunityUser? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    private func setUpData() {
        guard let user = user else { return }
        userNameLabel.text = user.userName
        userMessageLabel.text = user.userStatusComment
        contentCntLabel.text = "\(user.reviewCount)"
        follingCntLabel.text = "\(user.followingCount)"
        followerCntLabel.text = "\(user.followerCount)"
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 24)
        profileSquareView.applyRadius(radius: 3)
        profileSquareView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
}
