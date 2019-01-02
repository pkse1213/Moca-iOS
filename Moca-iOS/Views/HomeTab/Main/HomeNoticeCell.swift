//
//  HomeNoticeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 3..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class HomeNoticeCell: UITableViewCell {

    @IBOutlet var bigImageView: UIImageView!
    @IBOutlet var smallImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        bigImageView.applyRadius(radius: 23)
    }

}
