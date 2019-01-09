//
//  HotPlaceVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class HotPlaceVC: UIViewController {
    @IBOutlet var hotPlaceTableView: UITableView!
    var hotPlaces: [HotPlaceCafe]? {
        didSet{ hotPlaceTableView.reloadData() }
    }
    var placeId = 1
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initData() {
        HotPlaceListService.shareInstance.getHotPlaceList(hotPlaceId: placeId, token: token, completion: { (res) in
            self.hotPlaces = res
        }) { (err) in
            print("핫플레이스 리스트 실패 \(err)")
        }
    }
    
    private func setUpTableView() {
        hotPlaceTableView.delegate = self
        hotPlaceTableView.dataSource = self
    }

}

extension HotPlaceVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let places = hotPlaces else { return 0 }
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let places = hotPlaces?[indexPath.row] else { return cell }
        if let cafeCell = hotPlaceTableView.dequeueReusableCell(withIdentifier: "HotPlaceCafeCell", for: indexPath) as? HotPlaceCafeCell {
            cafeCell.cafe = places
            cell = cafeCell
        }
        
        return cell
    }
    
    
}
