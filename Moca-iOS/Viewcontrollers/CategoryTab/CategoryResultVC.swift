//
//  CategoryResultVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 5..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CategoryResultVC: UIViewController {
    var location: String = ""
    var options:[String] = []
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var conceptId: [Int] = []
    var menuId: [Int] = []
    var locationId = 0
    @IBOutlet weak var optionCollectionView: UICollectionView!
    @IBOutlet weak var cafeTableView: UITableView!
    var cafes:[CategoryCafe]? {
        didSet{
            cafeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(options)
        print(conceptId)
        print(menuId)
        
        setUpListView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initData() {
        let parameter: [String: Any] = ["concept" : conceptId,
                                        "menu" : menuId ]
        
        CategoryCafeService.shareInstance.getCategoryCafe(locationId: locationId, parameter: parameter, token: token, completion: { (cafeList) in
            self.cafes = cafeList
            print("카테고리 카페 리스트 성공")
        }) { (err) in
            print("카테고리 카페 리스트 실패")
        }
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
                locationCell.locationLabel.text = location + "구"
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
        guard let cafeNum = cafes?.count else { return 0 }
        return cafeNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let cafe = cafes?[indexPath.row] else { return cell }
        
        if let cafeCell = cafeTableView.dequeueReusableCell(withIdentifier: "CategoryCafeCell") as? CategoryCafeCell {
            cafeCell.cafeImageView.imageFromUrl(cafe.cafeImgURL, defaultImgPath: "")
            cafeCell.cafeNameLabel.text = cafe.cafeName
            cafeCell.cafeAddressLabel.text = cafe.cafeAddressDetail
            cafeCell.options.append(cafe.cafeConceptName)
            cafeCell.options.append(cafe.cafeMainMenuName)
            cell = cafeCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cafe = cafes?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            vc.cafeId = cafe.cafeID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
