//
//  MocaPlusDetailVC.swift
//  Moca-iOS
//
//  Created by soomin on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPlusDetailVC: UIViewController {
    @IBOutlet weak var mocaPlusDetailTableView: UITableView!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var mocaPlusSubject: MocaPlusSubject?
    var mocaPlusContent: [MocaPlusContent]? {
        didSet { mocaPlusDetailTableView.reloadData() }
    }
    
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
        mocaPlusDetailTableView.dataSource = self
        mocaPlusDetailTableView.delegate = self
    }
    
    private func initData() {
        guard let mocaPlusSubject = mocaPlusSubject else { return }
        MocaPlusContentService.shareInstance.getMocaPlusContents(plusId: mocaPlusSubject.plusSubjectID, token: token, completion: { (res) in
            self.mocaPlusContent = res
        }) { (err) in
            print("mocaPlusContent 실패 \(err)")
        }
    }
}

extension MocaPlusDetailVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mocaPlusContent = mocaPlusContent, let _ = mocaPlusSubject else { return 0 }
        if section == 0 {
            return 1
        } else {
            return mocaPlusContent.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let mocaPlusContent = mocaPlusContent?[indexPath.row], let _ = mocaPlusSubject else { return cell }
        
        switch indexPath.section {
        case 0:
            if let topicCell = tableView.dequeueReusableCell(withIdentifier: "MocaPlusDetailTopicCell", for: indexPath) as? MocaPlusDetailTopicCell {
                topicCell.mocaPlusSubject = mocaPlusSubject
                cell = topicCell
            }
        case 1:
            if let contentCell = tableView.dequeueReusableCell(withIdentifier: "MocaPlusContentCell", for: indexPath) as? MocaPlusContentCell {
                contentCell.mocaPlusContent = mocaPlusContent
               
                cell = contentCell
            }
        default:
            return cell
        }
        return cell
        
    }
    
}
