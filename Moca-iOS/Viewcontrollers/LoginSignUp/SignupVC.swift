//
//  SignupVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 04/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpProfileImag()
        setUpImageSelect()
        setUpButton()
    }
    
    // ProfileImage 원형 처리
    private func setUpProfileImag() {
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    // 회원가입, 취소 버튼 원형 처리
    private func setUpButton() {
        signupButton.layer.masksToBounds = false
        signupButton.layer.cornerRadius = 19
        signupButton.clipsToBounds = true
        
        cancelButton.layer.masksToBounds = false
        cancelButton.layer.cornerRadius = 19
        cancelButton.clipsToBounds = true
        cancelButton.layer.borderColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1)
        cancelButton.layer.borderWidth = 1.0
    }
    
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
    // 여기까지 이미지 선택
}

extension SignupVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
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
        profileImage.image = newImg
        dismiss(animated: true, completion: nil)
    }
}
