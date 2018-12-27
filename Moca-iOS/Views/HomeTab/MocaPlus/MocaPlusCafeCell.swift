//
//  MocaPlusCafeCell.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusCafeCell: UITableViewCell {
    
    @IBOutlet weak var cafeLocationLabel: UILabel!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeContentsLabel: UILabel!
    @IBOutlet weak var cafeDetailStackView: UIStackView!
    @IBOutlet weak var cafeMenuImageCollectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUpCollectionView()
        cafeContentsLabel.numberOfLines = 0
    }
    
    private func setUpCollectionView() {
        self.cafeMenuImageCollectionView.delegate = self
        self.cafeMenuImageCollectionView.dataSource = self
    }
}

extension MocaPlusCafeCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cafeMenuImageCollectionView.dequeueReusableCell(withReuseIdentifier: "MocaPlusCafeImageCell", for: indexPath) as! MocaPlusCafeImageCell
        
        return cell
    }
    
    // 셀 사이 거리 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
