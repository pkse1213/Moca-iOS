//
//  LikeCafeDetailVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 02/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class LikeCafeDetailVC: UIViewController {
    
    
    @IBOutlet var likeCafeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpTableView() {
        likeCafeListTableView.delegate = self
        likeCafeListTableView.dataSource = self
    }
}

extension LikeCafeDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeCafeListTableView.dequeueReusableCell(withIdentifier: "LikeCafeDetailTableViewCell", for: indexPath) as! LikeCafeDetailTableViewCell
        
        return cell
    }
    
    
}
