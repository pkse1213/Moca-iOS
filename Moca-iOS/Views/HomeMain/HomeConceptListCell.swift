//
//  ConceptListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeConceptListCell: UICollectionViewCell {
    
    @IBOutlet weak var conceptImageView: UIImageView!
    @IBOutlet weak var conceptNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        conceptImageView.applyRadius(radius: 40)
    }
}
