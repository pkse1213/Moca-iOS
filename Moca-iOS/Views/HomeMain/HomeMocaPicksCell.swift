//
//  MocaPicksCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeMocaPicksCell: UITableViewCell {

    @IBOutlet weak var mocaPickCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        self.mocaPickCollectionView.delegate = self
        self.mocaPickCollectionView.dataSource = self
    }

}

extension HomeMocaPicksCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mocaPickCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeMocaPicksCafeListCell", for: indexPath) as! HomeMocaPicksCafeListCell
        return cell
    }
    
    
}
