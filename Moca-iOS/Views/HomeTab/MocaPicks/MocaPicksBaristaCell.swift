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
    @IBOutlet weak var baristaNameLabel: UILabel!
    @IBOutlet weak var baristaInfoLabel: UILabel!
    var cafeId = 0
    weak var delegate: ListViewCellDelegate?
    var barista: MocaPicksEvaluate? {
        didSet { setUpData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView() {
        baristaImageView.applyRadius(radius: 23)
    }
    
    private func setUpData() {
        guard let barista = barista else { return }
        baristaNameLabel.text = barista.baristaName
        baristaInfoLabel.text = barista.baristaTitle
    }
    
    @IBAction func pushBaristaDetailAction(_ sender: UIButton) {
        guard let barista = barista else { return }
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "MocaPicksBaristaDetailVC") as? MocaPicksBaristaDetailVC {
            print("barista.baristaID \(barista.baristaID)")
            print("cafeId \(cafeId)")
            
            vc.baristaId = barista.baristaID
            vc.cafeId = cafeId
            delegate?.goToViewController(vc: vc)
        }
    }
}
