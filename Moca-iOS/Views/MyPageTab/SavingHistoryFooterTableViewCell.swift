//
//  SavingHistoryFooterTableViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class SavingHistoryFooterTableViewCell: UITableViewCell {
    
    
    @IBOutlet var historyImage: UIImageView!
    @IBOutlet var cafeName: UILabel!
    @IBOutlet var savingDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
