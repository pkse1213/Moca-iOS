//
//  MocaPicksDetailCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksBaristaDetailCell: UITableViewCell {
    @IBOutlet weak var profileBackgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var baristaNameLabel: UILabel!
    @IBOutlet weak var evaluationNameLabel: UILabel!
    @IBOutlet weak var evaluationScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        profileBackgroundView.applyRadius(radius: 5)
        profileBackgroundView.applyBorder(width: 0.5, color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
        
        profileImageView.applyRadius(radius: 23)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
