//
//  PopularCollectionViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 04/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var popularView: UIView!
    @IBOutlet var popularPofileImage: UIImageView!
    @IBOutlet var popularNameLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        popularPofileImage.layer.borderWidth = 0.3
        popularPofileImage.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        popularPofileImage.layer.masksToBounds = false
        popularPofileImage.layer.cornerRadius = popularPofileImage.frame.height/2
        popularPofileImage.clipsToBounds = true
        
        popularView.layer.borderWidth = 0.3
        popularView.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        popularView.layer.masksToBounds = false
        popularView.layer.cornerRadius = 5.0
        popularView.clipsToBounds = true
    }
}
