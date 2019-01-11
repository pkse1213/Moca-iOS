//
//  MocaPicksDetailVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 28..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksBaristaDetailVC: UIViewController {

    @IBOutlet weak var baristaDetailTableView: UITableView!
    var baristaId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        baristaDetailTableView.delegate = self
        baristaDetailTableView.dataSource = self
    }
}

extension MocaPicksBaristaDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let baristaCell = baristaDetailTableView.dequeueReusableCell(withIdentifier: "MocaPicksBaristaDetailCell") as? MocaPicksBaristaDetailCell {
            cell = baristaCell
        }
        return cell
    }
    
}
