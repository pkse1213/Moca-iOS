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
    @IBOutlet weak var profileBackgroundView: UIView!
    @IBOutlet weak var profileSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        communityTableView.delegate = self
        communityTableView.dataSource = self
        
        profileSquareView.applyRadius(radius: 3)
        profileSquareView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }

}

extension CommunityTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let feedCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
            cell = feedCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityContentVC") as? CommunityContentVC {
             self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
}
