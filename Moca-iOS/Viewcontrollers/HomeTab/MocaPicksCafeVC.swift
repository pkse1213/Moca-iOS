//
//  MocaPicksCafeVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksCafeVC: UIViewController {
    @IBOutlet weak var baristaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
    }
    private func setUpListView() {
        baristaTableView.delegate = self
        baristaTableView.dataSource = self
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
}

extension MocaPicksCafeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            if let imageCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksImageCell") as? MocaPicksImageCell {
                cell = imageCell
            }
        } else if indexPath.section == 1 {
            if let headerCell = baristaTableView.dequeueReusableCell(withIdentifier: "BaristaHeaderCell") {
                cell = headerCell
            }
        } else if indexPath.section == 2 {
            if let baristaCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksBaristaCell") as? MocaPicksBaristaCell {
                baristaCell.delegate = self
                cell = baristaCell
            }
        } else if indexPath.section == 3 {
            if let evaluationCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksEvaluationCell") as? MocaPicksEvaluationCell {
                cell = evaluationCell
            }
        } else if indexPath.section == 4 {
            if let allEvaluationCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksAllEvaluationCell") as? MocaPicksAllEvaluationCell {
                cell = allEvaluationCell
            }
        }
        return cell
    }
    
}

extension MocaPicksCafeVC: ListViewCellDelegate {
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

