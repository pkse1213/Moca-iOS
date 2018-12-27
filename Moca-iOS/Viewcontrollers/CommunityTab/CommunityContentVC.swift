//
//  CommunityContentVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentVC: UIViewController, UIGestureRecognizerDelegate {
    let colors = [#colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    
    @IBOutlet weak var imageCntLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var cotentTableView: UITableView!
    
    @IBOutlet weak var textBackgroundView: UIView!
    @IBOutlet weak var textSquareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpListView()
        setUpView()
    }
    
    private func setUpView() {
        textSquareView.applyBorder(width: 0.5, color: #colorLiteral(red: 0.8469749093, green: 0.8471175432, blue: 0.8469561338, alpha: 1))
        textBackgroundView.applyRadius(radius: 39/2)
        imageCntLabel.text = "1/\(colors.count)"
    }
    
    private func setUpListView() {
//        let gesture = UIPanGestureRecognizer(target: self, action: Selector(("wasDragged:")))
//        cotentTableView.addGestureRecognizer(gesture)
//        cotentTableView.isUserInteractionEnabled = true
//        gesture.delegate = self
//        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        cotentTableView.delegate = self
        cotentTableView.dataSource = self
        cotentTableView.applyRadius(radius: 10)
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)
            if(gestureRecognizer.view!.center.y < 462) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            }else {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 554)
            }
            
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
        
    }
}

extension CommunityContentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght = imageCollectionView.frame.width
        return CGSize(width: lenght, height: lenght)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            cell = imageCell
        }
        return cell
    }
    
}

extension CommunityContentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            if let contentCell = cotentTableView.dequeueReusableCell(withIdentifier: "CommunityContentCell") as? CommunityContentCell {
                cell = contentCell
            }
            
        } else {
            if let commentCell = cotentTableView.dequeueReusableCell(withIdentifier: "CommunityCommentCell") as? CommunityCommentCell {
                cell = commentCell
            }
        }
        
        return cell
    }
    
}

extension CommunityContentVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            let indexPath = imageCollectionView.indexPathForItem(at: scrollView.contentOffset)
            if let index = indexPath?.item {
                imageCntLabel.text = "\(index+1)/\(colors.count)"
            }
            
        }
    }
}
