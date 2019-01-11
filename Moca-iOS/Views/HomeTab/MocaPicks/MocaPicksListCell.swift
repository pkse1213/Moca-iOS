//
//  MocaPicksListCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksListCell: UITableViewCell {

    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var mocaPicks: MocaPicks? {
        didSet { setUpData() }
    }
    var isScrap = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    @IBAction func scrapAction(_ sender: UIButton) {
        guard let mocaPicks = mocaPicks else { return }
        switch isScrap {
        case true:
            CafeScrapService.shareInstance.deleteCafeScrap(cafeId: mocaPicks.cafeID, token: token, completion: { (message) in
                self.scrapButton.setImage(#imageLiteral(resourceName: "commonScrapWhiteLine"), for: .normal)
                self.isScrap = !self.isScrap
            }) { (err) in
                print("언팔로우 실패 \(err)")
            }
        case false:
            CafeScrapService.shareInstance.postCafeScrap(cafeId: mocaPicks.cafeID, token: token, completion: { (message) in
                self.isScrap = !self.isScrap
                self.scrapButton.setImage(#imageLiteral(resourceName: "commonScrapFilled"), for: .normal)
            }) { (err) in
                print("팔로우 실패 \(err)")
            }
        default:
            break
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpData() {
        guard let mocaPicks = mocaPicks else { return }
        nameLabel.text = mocaPicks.cafeName
        addressLabel.text = mocaPicks.addressDistrictName
        self.isScrap = mocaPicks.scrabIs
        cafeImageView.imageFromUrl(mocaPicks.evaluatedCafeImgURL, defaultImgPath: "")
        switch mocaPicks.scrabIs {
        case true:
            self.scrapButton.setImage(#imageLiteral(resourceName: "commonScrapFilled"), for: .normal)
        case false:
            self.scrapButton.setImage(#imageLiteral(resourceName: "commonScrapWhiteLine"), for: .normal)
        default:
            break
        }
    }

}
