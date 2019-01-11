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
    let conceptNames = ["감성",  "한옥",  "루프탑", "플라워", "북카페", "드라이브", "애견", "기타"]
    let menuNames = ["커피", "차", "베이커리", "생과일", "디저트", "기타"]
    weak var delegate: ListViewCellDelegate?
    
    var unit: CGFloat = 0.0
    var conceptSelectedId: Set<Int> = []
    var menuSelectedId: Set<Int> = []
    var optionSelected: Set<String> = []
    var locationId = 0
    var locationName = ""
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
        applyButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        applyButton.backgroundColor = #colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1)
        locationId = sender.tag
        locationName = sender.currentTitle ?? ""
        pinImageView.center.x = sender.center.x
        pinImageView.center.y = sender.center.y-19
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "CategoryTab", bundle: nil).instantiateViewController(withIdentifier: "CategoryResultVC") as? CategoryResultVC {
            if optionSelected.count == 0 {
                vc.options.append(contentsOf: menuNames)
                vc.options.append(contentsOf: conceptNames)
            } else {
                vc.options = Array(optionSelected)
            }
            
            vc.menuId = Array(menuSelectedId)
            vc.conceptId = Array(conceptSelectedId)
            vc.locationId = locationId
            vc.location = locationName
            print(menuSelectedId)
            print(conceptSelectedId)
            delegate?.goToViewController(vc: vc)
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
                    optionSelected.insert(conceptNames[indexPath.row])
                } else {
                    conceptSelectedId.remove(indexPath.item+1)
                    optionSelected.remove(conceptNames[indexPath.row])
                }
            } else if collectionView == menuCollectionView {
                if cell.selectedFlag {
                    menuSelectedId.insert(indexPath.item+1)
                    optionSelected.insert(menuNames[indexPath.row])
                } else {
                    menuSelectedId.remove(indexPath.item+1)
                    optionSelected.remove(menuNames[indexPath.row])
                }
            }
        }
    }
    
}
