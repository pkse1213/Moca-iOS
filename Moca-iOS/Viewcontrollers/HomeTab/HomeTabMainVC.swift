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
    
    private func setUpView() {
        searchBarView.applyRadius(radius: 5)
        searchBarView.applyBorder(width: 1.0, color: #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    }
    
    private func setUpTableView() {
        self.homeTabTableView.delegate = self
        self.homeTabTableView.dataSource = self
    }
}

extension HomeTabMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
        }
    }
    
    
}
