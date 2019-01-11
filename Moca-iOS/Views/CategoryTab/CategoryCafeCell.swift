//
//  CategoryCafeCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CategoryCafeCell: UITableViewCell {
    var options: [String] = []
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var optionCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        optionCollectionView.delegate = self
        optionCollectionView.dataSource = self
    }

}

extension CategoryCafeCell: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:11*options[indexPath.row].count+22 , height: 22)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let optionCell = optionCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedOptionCell", for: indexPath) as? SelectedOptionCell {
            optionCell.optionLabel.text = options[indexPath.item]
            optionCell.check = false
            cell = optionCell
        }
        return cell
    }
    
    
}
