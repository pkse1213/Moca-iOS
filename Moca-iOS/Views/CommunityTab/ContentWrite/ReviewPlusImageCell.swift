//
//  ReviewPlusImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ReviewPlusImageCell: UICollectionViewCell {
    
    @IBOutlet var selectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectImageView.layer.masksToBounds = false
        selectImageView.layer.cornerRadius = 5.0
        selectImageView.clipsToBounds = true
    }
}
