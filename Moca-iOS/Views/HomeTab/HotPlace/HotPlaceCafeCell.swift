//
//  ConceptTableViewCell.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class HotPlaceCafeCell: UITableViewCell {
    
    @IBOutlet var conceptCafeImg: UIImageView!
    @IBOutlet var conceptCafeName: UILabel!
    @IBOutlet var conceptCafeExplain: UILabel!
    @IBOutlet var conceptStar1: UIImageView!
    @IBOutlet var conceptStar2: UIImageView!
    @IBOutlet var conceptStar3: UIImageView!
    @IBOutlet var conceptStar4: UIImageView!
    @IBOutlet var conceptStar5: UIImageView!
    @IBOutlet var imageCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        circleImg()
        imageCollection.delegate = self
        imageCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func circleImg() {
        conceptCafeImg.layer.masksToBounds = false
        conceptCafeImg.layer.cornerRadius = conceptCafeImg.frame.height/2
        conceptCafeImg.clipsToBounds = true
    }

}

extension HotPlaceCafeCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let imgCell = imageCollection.dequeueReusableCell(withReuseIdentifier: "HotPlaceCafeImageCell", for: indexPath) as? HotPlaceCafeImageCell {
            cell = imgCell
        }
        
        return cell
    }
    
    
}
