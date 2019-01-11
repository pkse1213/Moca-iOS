//
//  HomeNoticeVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 3..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class HomeNoticeVC: UIViewController {
    @IBOutlet var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    
    private func setUpTableView() {
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
    }
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension HomeNoticeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let noticeCell = noticeTableView.dequeueReusableCell(withIdentifier: "HomeNoticeCell") as? HomeNoticeCell {
            cell = noticeCell
        }
        return cell
    }
}
