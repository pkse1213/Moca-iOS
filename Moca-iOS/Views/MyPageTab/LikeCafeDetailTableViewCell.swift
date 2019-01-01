//
//  LikeCafeDetailTableViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 02/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class LikeCafeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeLocationLabel: UILabel!
    @IBOutlet var cafeBackImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cafeBackImageView.layer.masksToBounds = false
        cafeBackImageView.layer.cornerRadius = 3
        cafeBackImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeCancelAction(_ sender: Any) {
        
    }
    
}
