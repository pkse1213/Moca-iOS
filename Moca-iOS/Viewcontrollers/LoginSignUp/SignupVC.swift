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
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var phoneTxt: UITextField!
    @IBOutlet var idTxt: UITextField!
    @IBOutlet var pwTxt: UITextField!
    @IBOutlet var pwCheckTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpProfileImag()
        setUpImageSelect()
        setUpButton()
        setUpTextField()
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
    
    @IBAction func signupAction(_ sender: Any) {
        SignupService.shared.signup(userId: gsno(idTxt.text), userPassword: gsno(pwTxt.text), userName: gsno(nameTxt.text), userPhone: gsno(phoneTxt.text), userImg: profileImage.image, completion: {
            
            let alert = UIAlertController(title: "회원가입", message: "회원가입 성공", preferredStyle: UIAlertController.Style.alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
                
                self.dismiss(animated: true)
            }
            
            alert.addAction(defaultAction)
            
            self.present(alert, animated: false, completion: nil)
            
        }) { (errCode) in
            self.simpleAlert(title: "회원가입", message: "회원가입 실패 \(errCode)")
        }
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
    
    // 텍스트필드 위로,,
    private func setUpTextField() {
        nameTxt.delegate = self
        phoneTxt.delegate = self
        idTxt.delegate = self
        pwTxt.delegate = self
        pwCheckTxt.delegate = self
        
        // 텍스트필드 누르면 위로 올라가게 설정
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc func endEditing(){
        nameTxt.resignFirstResponder()
        phoneTxt.resignFirstResponder()
        idTxt.resignFirstResponder()
        pwTxt.resignFirstResponder()
        pwCheckTxt.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    // 여기까지
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

extension SignupVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
        
        if textField == nameTxt {
            phoneTxt.becomeFirstResponder()
        }
        else if textField == phoneTxt {
            idTxt.becomeFirstResponder()
        }
        else if textField == idTxt {
            pwTxt.becomeFirstResponder()
        }
        else if textField == pwTxt {
            pwCheckTxt.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
        
//        textField.resignFirstResponder()
        
//        return true
    }
}
