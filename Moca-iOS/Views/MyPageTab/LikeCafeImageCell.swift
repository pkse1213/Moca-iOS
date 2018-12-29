//
//  LikeCafeCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 2018. 12. 29..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class LikeCafeImageCell: UICollectionViewCell {
    
    @IBOutlet weak var likeCafeImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeCafeImageView.layer.masksToBounds = false
        likeCafeImageView.layer.cornerRadius = likeCafeImageView.frame.height/2
        likeCafeImageView.clipsToBounds = true
    }
}
