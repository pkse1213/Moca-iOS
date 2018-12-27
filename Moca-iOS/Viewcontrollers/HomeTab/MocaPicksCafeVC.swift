//
//  MocaPicksCafeVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MocaPicksCafeVC: UIViewController {

    let colors = [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)]
    var progressUnit: Float = 0
    var count = 0
    
    @IBOutlet weak var cafeImageCollectionView: UICollectionView!
    @IBOutlet weak var baristaTableView: UITableView!
    @IBOutlet weak var scrollProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
        progressUnit = Float(1)/Float(colors.count)
        scrollProgressView.progress = progressUnit
    }
    
    private func setUpListView() {
        cafeImageCollectionView.delegate = self
        cafeImageCollectionView.dataSource = self
        cafeImageCollectionView.isPagingEnabled = true
        baristaTableView.delegate = self
        baristaTableView.dataSource = self
        baristaTableView.applyRadius(radius: 10)
        
    }
}

extension MocaPicksCafeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            if let headerCell = baristaTableView.dequeueReusableCell(withIdentifier: "BaristaHeaderCell") {
                cell = headerCell
            }
        } else if indexPath.section == 1 {
            if let baristaCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksBaristaCell") as? MocaPicksBaristaCell {
                cell = baristaCell
            }
        } else if indexPath.section == 2 {
            if let evaluationCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksEvaluationCell") as? MocaPicksEvaluationCell {
                cell = evaluationCell
            }
        } else if indexPath.section == 3 {
            if let allEvaluationCell = baristaTableView.dequeueReusableCell(withIdentifier: "MocaPicksAllEvaluationCell") as? MocaPicksAllEvaluationCell {
                cell = allEvaluationCell
            }
        }
        
        return cell
    }
    
}

extension MocaPicksCafeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: width , height: 228*width/375)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cafeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as! CommunityContentImageCell
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
    
}

extension MocaPicksCafeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            scrollProgressView.progress = Float(scrollView.contentOffset.x+scrollView.frame.width) / Float(scrollView.frame.width*CGFloat(colors.count))
            
        }
    }
}
