//
//  CafeDetailFooterCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailReviewFooterCell: UITableViewCell {
    
    var parentVC = UIViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func goToReviewAction(_ sender: Any) {
        if let vc = parentVC.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as? ReviewVC {
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
