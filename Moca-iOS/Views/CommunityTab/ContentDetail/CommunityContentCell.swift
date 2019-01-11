//
//  CommunityContentCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var review: CommunityReview? {
        didSet { setUpData() }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpData() {
        guard let review = review else { return }
        nameLabel.text = review.userName
        contentLabel.text = review.reviewContent
        timeLabel.text = review.time
        profileImageView.imageFromUrl(review.userImgURL, defaultImgPath: "commonDefaultimage")
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 20)
    }

}
