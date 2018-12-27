//
//  MocaPicksBaristaCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksBaristaCell: UITableViewCell {

    @IBOutlet weak var baristaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        baristaImageView.applyRadius(radius: 23)
    }
}
