//
//  MocaPlusCafeImageCell.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusCafeImageCell: UICollectionViewCell {
    @IBOutlet weak var defaultImageView: UIImageView!
    @IBOutlet weak var cafeMenuImageView: UIImageView!
    
    var touch = false {
        didSet { setUpImage() }
    }
    
    private func setUpImage() {
        defaultImageView.isHidden = !defaultImageView.isHidden
        cafeMenuImageView.isHidden = !cafeMenuImageView.isHidden
    }
}
