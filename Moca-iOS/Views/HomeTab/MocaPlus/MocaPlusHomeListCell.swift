//
//  MocaPlusHomeListCell.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusHomeListCell: UITableViewCell {
    
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var mocaPlusSubject: MocaPlusSubject? {
        didSet { setUpData()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    private func setUpData() {
        guard let mocaPlusSubject = mocaPlusSubject else { return }
        titleLabel.text = mocaPlusSubject.plusSubjectTitle
        nameLabel.text = mocaPlusSubject.editorName
        profileImageView.applyRadius(radius: profileImageView.frame.width/2)
    }
}
