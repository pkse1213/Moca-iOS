//
//  MocaPlusHomeListCell.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusHomeListCell: UITableViewCell {
    
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
//        profileImageView.layer.borderWidth = 1
//        profileImageView.layer.masksToBounds = false
//        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
//        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
