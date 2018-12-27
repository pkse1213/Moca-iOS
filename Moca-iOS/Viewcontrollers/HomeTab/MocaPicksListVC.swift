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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        mocaPicksTableView.delegate = self
        mocaPicksTableView.dataSource = self
    }

}

extension MocaPicksListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let mocaPicksCell = mocaPicksTableView.dequeueReusableCell(withIdentifier: "MocaPicksListCell") as? MocaPicksListCell {
            cell = mocaPicksCell
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "MocaPicksCafeVC") as? MocaPicksCafeVC {
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
