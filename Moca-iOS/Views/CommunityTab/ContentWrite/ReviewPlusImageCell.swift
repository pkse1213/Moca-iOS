//
//  ReviewPlusImageCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ReviewPlusImageCell: UICollectionViewCell {
    
    @IBOutlet var selectImageView: UIImageView!
    // 추가
    var presVC : UIViewController?
    // 추가
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpImageSelect()
    }
    
    // 이미지 선택
    private func setUpImageSelect() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        imageTap.delegate = self
        
        self.selectImageView.addGestureRecognizer(imageTap)
    }
    
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                self.presVC?.present(picker, animated: true)
            } else {
                print("not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            self.presVC?.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        presVC?.present(actionSheet, animated: true)
    }

}

extension ReviewPlusImageCell  : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.presVC?.dismiss(animated: true, completion: nil)
    }
    
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
        selectImageView.image = newImg
        self.presVC?.dismiss(animated: true, completion: nil)
    }
}

