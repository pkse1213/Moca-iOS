//
//  CommunityTabMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityTabMainVC: UIViewController {

    @IBOutlet weak var communityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }

}

extension CommunityTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as! CommunityFeedCell
        return cell
    }
    
    
}
