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
        self.navigationItem.title = "Moca Plus"
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
        guard let mocaPlusSubject = mocaPlusSubject?[indexPath.row] else { return }
        if let vc = UIStoryboard(name: "MocaPlus", bundle: nil).instantiateViewController(withIdentifier: "MocaPlusDetailVC") as? MocaPlusDetailVC {
            vc.mocaPlusSubject = mocaPlusSubject
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
