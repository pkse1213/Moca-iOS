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
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var pinImageView: UIImageView!
   
    let menuDefaultImaeges = [#imageLiteral(resourceName: "filterCoffee"),#imageLiteral(resourceName: "filterTea"),#imageLiteral(resourceName: "filterBakery"),#imageLiteral(resourceName: "filterFruit"),#imageLiteral(resourceName: "filterDessert"),#imageLiteral(resourceName: "filterEtc")]
    let menuSelectedImages = [#imageLiteral(resourceName: "filterCoffeeRed"),#imageLiteral(resourceName: "filterTeaRed"),#imageLiteral(resourceName: "filterBakeryRed"),#imageLiteral(resourceName: "filterFruitRed"),#imageLiteral(resourceName: "filterDessertRed"),#imageLiteral(resourceName: "filterEtcRed")]
    let conceptDefaultImaeges = [#imageLiteral(resourceName: "filterMood"),#imageLiteral(resourceName: "filterHanok"),#imageLiteral(resourceName: "filterRooftop"),#imageLiteral(resourceName: "filterFlower"),#imageLiteral(resourceName: "filterBook"),#imageLiteral(resourceName: "filterDrive"),#imageLiteral(resourceName: "filterPet"),#imageLiteral(resourceName: "filterEtc")]
    let conceptSelectedImages = [#imageLiteral(resourceName: "filterMoodRed"),#imageLiteral(resourceName: "filterHanokRed"),#imageLiteral(resourceName: "filterRooftopRed"),#imageLiteral(resourceName: "filterFlowerRed"),#imageLiteral(resourceName: "filterBookRed"),#imageLiteral(resourceName: "filterDriveRed"),#imageLiteral(resourceName: "filterPetRed"),#imageLiteral(resourceName: "filterEtcRed")]
    var navigationController: UINavigationController?
    var unit: CGFloat = 0.0
    var conceptSelectedId: Set<Int> = []
    var menuSelectedId: Set<Int> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
        pinImageView.isHidden = true
        applyButton.isEnabled = false
    }
    
    @IBAction func locationSelectAction(_ sender: UIButton) {
        applyButton.isEnabled = true
        pinImageView.isHidden = false
        pinImageView.center.x = sender.center.x
        pinImageView.center.y = sender.center.y-19
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "CategoryTab", bundle: nil).instantiateViewController(withIdentifier: "CategoryResultVC") as? CategoryResultVC {
            print(menuSelectedId)
            print(conceptSelectedId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        if collectionView == menuCollectionView {
            return menuDefaultImaeges.count
        } else {
            return conceptDefaultImaeges.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == conceptCollectionView {
            if let conceptCell = conceptCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryConceptCell", for: indexPath) as? CategoryMenuCell {
                conceptCell.menuImageView.image = conceptDefaultImaeges[indexPath.item]
                conceptCell.defalutImage = conceptDefaultImaeges[indexPath.item]
                conceptCell.selectedImage = conceptSelectedImages[indexPath.item]
                cell = conceptCell
            }
        } else {
            
            if let menuCell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryMenuCell", for: indexPath) as? CategoryMenuCell {
                menuCell.menuImageView.image = menuDefaultImaeges[indexPath.item]
                menuCell.defalutImage = menuDefaultImaeges[indexPath.item]
                menuCell.selectedImage = menuSelectedImages[indexPath.item]
                cell = menuCell
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryMenuCell {
            cell.selectedFlag = !cell.selectedFlag
            if collectionView == conceptCollectionView {
                if cell.selectedFlag {
                    conceptSelectedId.insert(indexPath.item+1)
                } else {
                    conceptSelectedId.remove(indexPath.item+1)
                }
            } else if collectionView == menuCollectionView {
                if cell.selectedFlag {
                    menuSelectedId.insert(indexPath.item+1)
                } else {
                    menuSelectedId.remove(indexPath.item+1)
                }
            }
        }
    }
    
}
