//
//  ReviewWrittingCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ReviewWrittingCell: UITableViewCell {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    var parentVC = UIViewController()
    @IBOutlet var cafeNameText: UITextField!
    @IBOutlet var cafeLocationText: UITextField!
    
    @IBOutlet var completeBtn: UIButton!
    @IBOutlet var explainText: UITextField!
    @IBOutlet var reviewContentsText: UITextView!
    
    
    
    var reviewImageArr: [UIImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        
        cafeLocationText.isEnabled = true
        
        reviewImageArr = [UIImage]()
        setUpButton()
        registerGesture()
    }
    
    // 버튼 radius
    private func setUpButton() {
        completeBtn.layer.masksToBounds = false
        completeBtn.layer.cornerRadius = 5.0
        completeBtn.clipsToBounds = true
    }
    
    private func setUpCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    private func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                self.parentVC.present(picker, animated: true)
            }
            else {
                print("not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            self.parentVC.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        parentVC.present(actionSheet, animated: true)
    }
    
    
    // 카페 이름 찾기 관련
    private func registerGesture() {
        let inputGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(inputCafeNameAction(_:)))
        cafeNameText.addGestureRecognizer(inputGestureRecognizer)
    }
    
    @objc func inputCafeNameAction(_: UITextField) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "WriteReviewSearchVC") as? WriteReviewSearchVC {
            
            vc.parentVC = parentVC
            
            parentVC.present(vc, animated: true)
        }
    }
}

extension ReviewWrittingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if reviewImageArr.count == 0 {
            return 2
        }
        else if reviewImageArr.count < 5 {
            return reviewImageArr.count + 1
        }
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let imageCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewPlusImageCell", for: indexPath) as? ReviewPlusImageCell {
            
            if indexPath.row < reviewImageArr.count {
                imageCell.selectImageView.image = reviewImageArr[indexPath.row]
            }
            
            cell = imageCell
        }
        
        return cell
    }
    
    // delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageTapped()
    }
}


extension ReviewWrittingCell : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 취소할 때 (cancel)
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentVC.dismiss(animated: true, completion: nil)
    }

    // 사진 선택했을 떄
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImg = UIImage()
        
        if let possibleImg = info[.editedImage] as? UIImage {
            newImg = possibleImg
        }
        else if let possibleImg = info[.originalImage] as? UIImage {
            newImg = possibleImg
        }
        else {
            return
        }
        reviewImageArr.append(newImg)
        
        parentVC.dismiss(animated: true) {
            self.imageCollectionView.reloadData()
        }
    }
}
