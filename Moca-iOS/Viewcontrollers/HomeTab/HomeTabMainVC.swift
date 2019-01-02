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
    @IBOutlet weak var noticeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
        registerGesture()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpView() {
        searchBarView.applyRadius(radius: 5)
        searchBarView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    }
    
    private func setUpTableView() {
        self.homeTabTableView.delegate = self
        self.homeTabTableView.dataSource = self
    }
    
    private func registerGesture() {
        let searchTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToSearchAction(_:)))
        searchBarView.addGestureRecognizer(searchTapGestureRecognizer)
        
        let noticeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToNoticeActon(_:)))
        noticeImageView.addGestureRecognizer(noticeTapGestureRecognizer)
        
    }
    
    @objc func goToNoticeActon(_: UIImageView) {
        if let vc = UIStoryboard(name: "HomeTab", bundle: nil).instantiateViewController(withIdentifier: "HomeNoticeVC") as? HomeNoticeVC {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func goToSearchAction(_: UIImageView) {
        if let vc = UIStoryboard(name: "HomeSearch", bundle: nil).instantiateViewController(withIdentifier: "HomeSearchVC") as? HomeSearchVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // moca picks
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            if let mocaPicksCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeMocaPicksCell") as? HomeMocaPicksCell {
                mocaPicksCell.navigationController = self.navigationController
                
                cell = mocaPicksCell
            }
            
        } else if indexPath.row == 1 {
            if let conceptCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeConceptCell") as? HomeConceptCell {
                cell = conceptCell
            }
            
        } else {
            if let rankingCell = homeTabTableView.dequeueReusableCell(withIdentifier: "HomeRankingCell") as? HomeRankingCell {
                rankingCell.navigationController = self.navigationController
                cell = rankingCell
            }
        }
        return cell
    }
    
}
