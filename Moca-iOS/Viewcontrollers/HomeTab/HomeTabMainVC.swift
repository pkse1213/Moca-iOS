//
//  ViewController.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeTabMainVC: UIViewController {

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var homeTabTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    private func setUpView() {
        searchBarView.applyRadius(radius: 5)
        searchBarView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    }
    
    @objc func moreAction(_:UIImageView) {
        let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "HomeRankingListVC") as! HomeRankingListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpTableView() {
        self.homeTabTableView.delegate = self
        self.homeTabTableView.dataSource = self
    }
}

extension HomeTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // moca picks
        if indexPath.row == 0 {
            let cell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeMocaPicksCell") as! HomeMocaPicksCell
            return cell
        } else if indexPath.row == 1 {
            let cell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeConceptCell") as! HomeConceptCell
            return cell
        } else {
            let cell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeRankingCell") as! HomeRankingCell
            let moreBtnTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreAction(_:)))
            cell.moreBtnImageView.addGestureRecognizer(moreBtnTapGestureRecognizer)
            return cell
        }
    }
    
}
