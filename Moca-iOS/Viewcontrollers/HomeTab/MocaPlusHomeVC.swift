//
//  MocaPlusHomeVC.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusHomeVC: UIViewController {
    
    @IBOutlet weak var mocaPlusTableView: UITableView!
    var mocaPlusSubject: [MocaPlusSubject]? {
        didSet { mocaPlusTableView.reloadData() }
    }
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setUpTableView() {
        mocaPlusTableView.dataSource = self
        mocaPlusTableView.delegate = self
    }
    
    private func initData() {
        MocaPlusSubjectService.shareInstance.getMocaPlusSubject(length: -1, token: token, completion: { (res) in
            self.mocaPlusSubject = res
        }) { (err) in
            print("모카 플러스 리스트 실패 \(err)")
        }
    }
}

extension MocaPlusHomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mocaPlusSubject = mocaPlusSubject else { return 0 }
        return mocaPlusSubject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let mocaPlusSubject = mocaPlusSubject?[indexPath.row] else { return cell }
        
        if let mocaPluscell = tableView.dequeueReusableCell(withIdentifier: "MocaPlusHomeListCell") as? MocaPlusHomeListCell {
            mocaPluscell.mocaPlusSubject = mocaPlusSubject
            cell = mocaPluscell
        }
        
        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 상세보기 띄우기
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "MocaPlusDetailVC") as! MocaPlusDetailVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
