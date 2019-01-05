//
//  SavingHistoryVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class SavingHistoryVC: UIViewController {

    @IBOutlet var savingHistoryTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingHistoryTable.delegate = self
        savingHistoryTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension SavingHistoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 26
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if (indexPath.row % 12 == 0) {
            if let headerCell = savingHistoryTable.dequeueReusableCell(withIdentifier: "SavingHistoryHeaderTableViewCell", for: indexPath) as? SavingHistoryHeaderTableViewCell {
                
                cell = headerCell
            }
        }
        else if (indexPath.row % 12 == 11) {
            if let footerCell = savingHistoryTable.dequeueReusableCell(withIdentifier: "SavingHistoryFooterTableViewCell", for: indexPath) as? SavingHistoryFooterTableViewCell {
                
                cell = footerCell
            }
        }
        else {
            if let centerCell = savingHistoryTable.dequeueReusableCell(withIdentifier: "SavingHistoryTableViewCell", for: indexPath) as? SavingHistoryTableViewCell {
                
                cell = centerCell
            }
        }
        
        return cell
    }
    
    
}
