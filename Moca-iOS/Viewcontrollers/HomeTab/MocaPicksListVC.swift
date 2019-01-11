//
//  MocaPicksListVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksListVC: UIViewController {
    @IBOutlet weak var mocaPicksTableView: UITableView!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var mocaPicksCafes: [MocaPicks]? {
        didSet { mocaPicksTableView.reloadData() }
    }
    var first = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        if !first {
            first = false
        } else {
            initData()
        }
    }
    
    private func initData() {
        MocaPicksCafeService.shareInstance.getMocaPicksCafe(length: -1, token: token, completion: { (res) in
            self.mocaPicksCafes = res
        }) { (err) in
            print("모카 플러스 리스트 실패 \(err)")
        }
    }
    
    private func setUpTableView() {
        mocaPicksTableView.delegate = self
        mocaPicksTableView.dataSource = self
    }
}

extension MocaPicksListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mocaPicks = mocaPicksCafes else { return 0 }
        return  mocaPicks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let mocaPicks = mocaPicksCafes?[indexPath.row] else { return cell }
        if let mocaPicksCell = mocaPicksTableView.dequeueReusableCell(withIdentifier: "MocaPicksListCell") as? MocaPicksListCell {
            mocaPicksCell.mocaPicks = mocaPicks
            cell = mocaPicksCell
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "MocaPicksCafeVC") as? MocaPicksCafeVC {
            guard let mocaPicks = mocaPicksCafes?[indexPath.row] else { return }
            vc.cafeInfo = mocaPicks
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
