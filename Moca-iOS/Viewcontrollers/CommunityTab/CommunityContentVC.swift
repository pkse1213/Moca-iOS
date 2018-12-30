//
//  CommunityContentVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentVC: UIViewController, UIGestureRecognizerDelegate {
    let colors = [#colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9088876247, green: 0.7525063157, blue: 0.6986940503, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    
    @IBOutlet var textFieldViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var reviewContentViewTopConstraint: NSLayoutConstraint!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpView() {
//        if let view = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "sample").view {
//
//            commentView.addSubview(view)
//
//            view.translatesAutoresizingMaskIntoConstraints = false
//
//            let bottom = view.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
//            let top = view.topAnchor.constraint(equalTo: commentView.topAnchor)
//            let leading = view.leadingAnchor.constraint(equalTo: commentView.leadingAnchor)
//            let trailing = view.trailingAnchor.constraint(equalTo: commentView.trailingAnchor)
//            commentView.addConstraints([top, bottom, leading, trailing])
//            self.addChild( vc )
//            vc.view.frame = self.commentView.frame
//            self.commentView.addSubview( vc.view )
//            vc.didMove(toParent: self )
//        }
        
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "CommunityContentImageCell", for: indexPath) as? CommunityContentImageCell {
            imageCell.contentImageView.image = UIImage(named: "sample\(indexPath.item+1)")
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
            
        } else if scrollView is UITableView {
            if scrollView.contentOffset.y > 0.0 {
                UIView.animate(withDuration: 0.5) {
                    self.textSquareView.isHidden = false
                    self.textFieldViewBottomConstraint.constant = 0
                    self.reviewContentViewTopConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            if scrollView.contentOffset.y == 0.0 {
                UIView.animate(withDuration: 0.5) {
                    
                    self.textFieldViewBottomConstraint.constant = -54
                    self.reviewContentViewTopConstraint.constant = 418.67
                    self.view.layoutIfNeeded()
                }
                self.textSquareView.isHidden = true
            }
            
        }
    }
}

