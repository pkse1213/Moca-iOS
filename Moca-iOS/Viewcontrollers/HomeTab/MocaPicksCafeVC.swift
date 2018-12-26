//
//  MocaPicksCafeVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksCafeVC: UIViewController {

    @IBOutlet weak var cafeImageCollectionView: UICollectionView!
    @IBOutlet weak var baristaTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
    }
    
    private func setUpListView() {
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
        
        baristaTableView.delegate = self
        baristaTableView.dataSource = self
        baristaTableView.applyRadius(radius: 10)
    }
    
}

extension MocaPicksCafeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = baristaTableView.dequeueReusableCell(withIdentifier: "") as! UITableViewCell
        
        return cell
    }
    
}

extension MocaPicksCafeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cafeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as! CommunityContentImageCell
        return cell
        
    }
    
}
