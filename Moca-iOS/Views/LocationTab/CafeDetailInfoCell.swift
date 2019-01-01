//
//  CafeDetailInfoCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CafeDetailInfoCell: UITableViewCell {

    @IBOutlet weak var signatureMenuCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        signatureMenuCollectionView.delegate = self
        signatureMenuCollectionView.dataSource = self
    }
}

extension CafeDetailInfoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let menuCell = signatureMenuCollectionView.dequeueReusableCell(withReuseIdentifier: "SignatureMenuCell", for: indexPath) as? SignatureMenuCell {
            cell = menuCell
        }
        return cell
    }
    
    
}
