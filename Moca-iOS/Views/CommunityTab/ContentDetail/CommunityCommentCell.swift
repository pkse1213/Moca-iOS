//
//  CommunityCommentCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityCommentCell: UITableViewCell {
    var comment: ReviewComment? {
        didSet { setUpData() }
    }
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
  
    private func setUpData() {
        guard let comment = comment else { return }
        nameLabel.text = comment.userID
        contentLabel.text = comment.reviewCommentContent
        timeLabel.text = comment.time
        profileImageView.imageFromUrl(comment.userImgURL, defaultImgPath: "commonDefaultimage")
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 20)
    }
}
