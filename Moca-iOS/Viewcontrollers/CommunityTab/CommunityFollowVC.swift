//
//  CommunityFollowVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityFollowVC: UIViewController {

    @IBOutlet weak var followTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        followTableView.delegate = self
        followTableView.dataSource = self
    }
    
}

extension CommunityFollowVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followTableView.dequeueReusableCell(withIdentifier: "CommunityFollwCell") as! CommunityFollwCell
        
        return cell
    }
    
}
