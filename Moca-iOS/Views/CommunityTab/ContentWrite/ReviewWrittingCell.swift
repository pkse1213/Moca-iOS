//
//  ReviewWrittingCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ReviewWrittingCell: UITableViewCell {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // 추가
    var presentVC : UIViewController?
    // 추가
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }

}

extension ReviewWrittingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewPlusImageCell", for: indexPath) as? ReviewPlusImageCell {
            // 추가
            imageCell.presVC = presentVC
            
            cell = imageCell
        }
        return cell
    }
    
    
}
