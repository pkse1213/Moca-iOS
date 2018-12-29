//
//  MocaPicksCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeMocaPicksCell: UITableViewCell {

    var navigationController: UINavigationController?
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
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let cafeCell = mocaPickCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeMocaPicksCafeListCell", for: indexPath) as? HomeMocaPicksCafeListCell {
            cell = cafeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navi = navigationController else {
            return
        }
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "MocaPicksListVC") as? MocaPicksListVC {
            navi.pushViewController(vc, animated: true)
        }
    }
    
}
