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
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCircleImage()
        paddingTextField()
        setSwitch()
        setUpImageSelect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
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
//        MyPageEditService.shared.postMyPageEdit(token: token, user_name: gsno(nicknameTxt.text), user_password: "aaaaa", user_phone: gsno(phoneNumTxt.text), user_status_comment: gsno(stateMessageTxt.text), user_img: gsno(profileImageView.image?.accessibilityIdentifier), completion: { (myPageEditData) in
//            print("수정 성공")
//        }) { (errCode) in
//            print("수정 실패 || \(errCode)")
//        }
        
//        if let getImage = self.profileImageView.image {
//            //                //이미지를 멀티파트를 이용해 서버로 보내기 위한 data 형식으로 변환시켜줍니다
//            let imageData = getImage.jpegData(compressionQuality: 0.5)
//
//            MyPageEditService.shared.postMyPageEdit(token: token, userName: gsno(nicknameTxt.text), userPassword: gsno("aaaaa"), userPhone: gsno(phoneNumTxt.text), userStatusComment: gsno(stateMessageTxt.text), userImg: imageData, completion: { (myPageEditData) in
//                self.simpleAlert(title: "수정", message: "수정 성공")
//            }) { (errCode) in
//                self.simpleAlert(title: "수정실패", message: "수정 실패했습니다.")
//            }
//        }
        
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
