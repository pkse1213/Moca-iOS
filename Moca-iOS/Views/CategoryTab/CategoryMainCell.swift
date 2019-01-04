//
//  CatogoryMainCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CategoryMainCell: UITableViewCell {
    @IBOutlet weak var conceptCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var pinImageView: UIImageView!
    
    var concepts = ["","","","","","","",""]
    var menus = ["","","","","","","","","",""]
    var unit: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
        pinImageView.isHidden = true
    }
    
    @IBAction func locationSelectAction(_ sender: UIButton) {
        pinImageView.isHidden = false
        pinImageView.center.x = sender.center.x
        pinImageView.center.y = sender.center.y-19
    }
    
    private func setUpView() {
        applyButton.applyRadius(radius: 5)
    }
    
    private func setUpCollectionView() {
        conceptCollectionView.delegate = self
        conceptCollectionView.dataSource = self

        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }

}

extension CategoryMainCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.menuCollectionView.frame.height, height: self.menuCollectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        print("ererer")
        if collectionView == conceptCollectionView {
            if let conceptCell = conceptCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryConceptCell", for: indexPath) as? CategoryConceptCell {
                print("df")
                cell = conceptCell
            }
        } else {
            
            if let menuCell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryMenuCell", for: indexPath) as? CategoryMenuCell {
                print("Erer")
                cell = menuCell
            }
        }
        return cell
    }
    
    
}
