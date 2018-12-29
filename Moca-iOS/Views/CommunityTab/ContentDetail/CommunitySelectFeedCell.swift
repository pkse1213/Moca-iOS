//
//  CommunitySelectFeedCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunitySelectFeedCell: UITableViewCell {

    @IBOutlet weak var feedNameLabel: UILabel!
    @IBOutlet weak var choosedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
