//
//  CenceptCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeConceptCell: UITableViewCell {

    @IBOutlet weak var conceptListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        self.conceptListCollectionView.delegate = self
        self.conceptListCollectionView.dataSource = self
    }
}

extension HomeConceptCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let conceptCell = conceptListCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeConceptListCell", for: indexPath) as? HomeConceptListCell {
            cell = conceptCell
        }
        return cell
    }
    
    
}
