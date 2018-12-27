//
//  MocaPicksCafeVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksCafeVC: UIViewController {

    let colors = [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)]
    @IBOutlet weak var cafeImageCollectionView: UICollectionView!
    @IBOutlet weak var baristaTableView: UITableView!
    @IBOutlet weak var scrollProgressView: UIProgressView!
    
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
        cell.backgroundColor = colors[indexPath.item]
        return cell
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}
