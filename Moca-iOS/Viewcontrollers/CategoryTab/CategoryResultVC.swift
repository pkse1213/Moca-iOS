//
//  CategoryResultVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CategoryResultVC: UIViewController {
    let location: String = "강서구"
    let options = ["한옥", "드라이브", "커피", "디저트"]
    @IBOutlet weak var optionCollectionView: UICollectionView!
    @IBOutlet weak var cafeTableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpListView() {
        optionCollectionView.delegate = self
        optionCollectionView.dataSource = self
        
        cafeTableView.delegate = self
        cafeTableView.dataSource = self
    }

}

extension CategoryResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width:12.4*Double(location.count)+20 , height: 28)
        } else {
             return CGSize(width:12.4*Double(options[indexPath.row].count)+20 , height: 28)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return options.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if indexPath.section == 0 {
            if let locationCell = optionCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedLocationCell", for: indexPath) as? SelectedLocationCell{
                locationCell.locationLabel.text = location
                cell = locationCell
            }
        } else {
            if let optionCell = optionCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectedOptionCell", for: indexPath) as? SelectedOptionCell{
                optionCell.optionLabel.text = options[indexPath.item]
                cell = optionCell
            }
        }
        return cell
    }
    
    
}

extension CategoryResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let cafeCell = cafeTableView.dequeueReusableCell(withIdentifier: "CategoryCafeCell") as? CategoryCafeCell {
            cafeCell.cafeImageView.image = UIImage(named: "sample\(indexPath.row+1)")
            cell = cafeCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
