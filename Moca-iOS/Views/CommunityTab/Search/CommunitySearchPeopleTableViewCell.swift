//
//  CommunitySearchPeopleTableViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 04/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class CommunitySearchPeopleTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var followingButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    

    @IBAction func followAction(_ sender: Any) {
        
    }
}
