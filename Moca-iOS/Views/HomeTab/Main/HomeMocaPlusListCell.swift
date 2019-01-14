//
//  HomeMocaPlusListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class HomeMocaPlusListCell: UITableViewCell {
    var mocaPlus: MocaPlusSubject? {
        didSet { setUpData() }
    }
    @IBOutlet var subjectNameLabel: UILabel!
    @IBOutlet var editorLabel: UILabel!
    @IBOutlet var subjectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setUpData() {
        guard let mocaPlus = mocaPlus else { return }
        subjectNameLabel.text = mocaPlus.plusSubjectTitle
        editorLabel.text = "\(mocaPlus.editorName) 애디터"
        subjectImageView.imageFromUrl(mocaPlus.plusSubjectImgURL, defaultImgPath: "")
        
    }
}
