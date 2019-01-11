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
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    var mocaPlusSubject: MocaPlusSubject?
    var mocaPlusContent: [MocaPlusContent]? {
        didSet { mocaPlusDetailTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
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
