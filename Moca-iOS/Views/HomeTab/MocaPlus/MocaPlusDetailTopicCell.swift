//
//  MocaPlusDetailTopicCell.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusDetailTopicCell: UITableViewCell {
    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet var editorNameLabel: UILabel!
    var mocaPlusSubject: MocaPlusSubject? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setUpData() {
        guard let mocaPlusSubject = mocaPlusSubject else { return }
        topicTitleLabel.text = mocaPlusSubject.plusSubjectTitle
        editorNameLabel.text = "by \(mocaPlusSubject.editorName) 에디터"
        topicImageView.imageFromUrl(mocaPlusSubject.plusSubjectImgURL, defaultImgPath: "")
    }
}
