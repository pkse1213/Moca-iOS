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
    var placeName = ""
    var placeId = 1
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = "#" + placeName
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "commonBackBlack"), for: .normal)
        button.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backAction(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let place = hotPlaces?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            vc.cafeId = place.cafeID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
