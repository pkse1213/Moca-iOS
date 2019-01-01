//
//  ProfileModifyVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 01/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class ProfileModifyVC: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var completeButton: UIButton!
    @IBOutlet var nicknameTxt: UITextField!
    @IBOutlet var stateMessageTxt: UITextField!
    @IBOutlet var phoneNumTxt: UITextField!
    
    @IBOutlet var alarmSwitch: UISwitch!
    
    @IBOutlet var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCircleImage()
        paddingTextField()
        setSwitch()
        setUpImageSelect()
    }
    
    // 스위치 크기 설정
    private func setSwitch() {
        alarmSwitch.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
    }
    
    // 텍스트필드 패딩
    private func paddingTextField() {
        nicknameTxt.setLeftPaddingPoints(5.0)
        stateMessageTxt.setLeftPaddingPoints(5.0)
        phoneNumTxt.setLeftPaddingPoints(5.0)
    }
    
    // 원형 이미지
    private func setCircleImage() {
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    // 완료 버튼
    @IBAction func completeAction(_ sender: Any) {
        
    }
    
    // 취소 버튼
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // 이미지 선택
    private func setUpImageSelect() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        imageTap.delegate = self
        
        self.selectButton.addGestureRecognizer(imageTap)

    }
    
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                self.present(picker, animated: true)
            } else {
                print("not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
}

extension ProfileModifyVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        profileImageView.image = newImg
        dismiss(animated: true, completion: nil)
    }
}
