//
//  CommunityFollwCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityFollwCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    private func setUpView() {
        profileImageView.applyRadius(radius: 23)
    }
}
