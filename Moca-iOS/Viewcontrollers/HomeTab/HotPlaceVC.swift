//
//  HotPlaceVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 06/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class HotPlaceVC: UIViewController {
    
    @IBOutlet var conceptTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        conceptTableView.delegate = self
        conceptTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

}

extension HotPlaceVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let conceptCell = conceptTableView.dequeueReusableCell(withIdentifier: "ConceptTableViewCell", for: indexPath) as? ConceptTableViewCell {
            cell = conceptCell
        }
        
        return cell
    }
    
    
}
