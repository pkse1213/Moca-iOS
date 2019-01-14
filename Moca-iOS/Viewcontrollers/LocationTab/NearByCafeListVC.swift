//
//  NearCafeListVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class NearByCafeListVC: UIViewController {
    var nearByCafes: [NearByCafe]? 
    @IBOutlet var nearCafeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NanumGothicBold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = "주변 카페"
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
    
    private func setUpTableView() {
        nearCafeTableView.delegate = self
        nearCafeTableView.dataSource = self
    }

}

extension NearByCafeListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cafes = nearByCafes else { return 0 }
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let cafe = nearByCafes?[indexPath.row] else { return cell }
        if let cafeCell = nearCafeTableView.dequeueReusableCell(withIdentifier: "NearByCafeCell") as? NearByCafeCell {
            cafeCell.cafe = cafe
            cell = cafeCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationCafeDetailVC") as? LocationCafeDetailVC {
            guard let cafe = nearByCafes?[indexPath.row] else { return }
            vc.cafeId = cafe.cafeID
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
