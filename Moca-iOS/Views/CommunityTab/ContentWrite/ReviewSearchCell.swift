//
//  ReviewSearchCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class ReviewSearchCell: UITableViewCell {
    
    @IBOutlet var cafeName: UILabel!
    @IBOutlet var cafeLocation: UILabel!
    @IBOutlet var isSelectedView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.isSelectedView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
