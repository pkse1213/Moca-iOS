//
//  LoginVC.swift
//  Moca-iOS
//
//  Created by 조수민 on 04/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import UIKit
import Hero

class LoginVC: UIViewController {
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var idCircleImage: UIImageView!
    @IBOutlet var pwCircleImage: UIImageView!
    @IBOutlet var idTxt: UITextField!
    @IBOutlet var pwTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTxtField()
        setLoginBtn()
    }
    
    // 텍스트필드 delegate
    private func setUpTxtField() {
        idTxt.delegate = self
        pwTxt.delegate = self
        
        idCircleImage.isHidden = true
        pwCircleImage.isHidden = true
        
        // 텍스트필드 누르면 위로 올라가게 설정
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    // 텍스트필드 위로,,
    @objc func endEditing(){
        idTxt.resignFirstResponder()
        pwTxt.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    // 여기까지
    
    // 로그인 버튼 radius
    private func setLoginBtn() {
        loginBtn.layer.masksToBounds = false
        loginBtn.layer.cornerRadius = 19
        loginBtn.clipsToBounds = true
    }
    
    // 로그인
    @IBAction func loginAction(_ sender: Any) {
        guard let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")  as? UITabBarController else { return }
        dvc.hero.isEnabled = true
        dvc.hero.modalAnimationType = HeroDefaultAnimationType.zoom
        self.present(dvc, animated: true)
        
//        let body = [
//            "user_id" : gsno(idTxt.text),
//            "user_password" : gsno(pwTxt.text)
//        ]
//
//        LoginService.shared.login(body: body, completion: { (token) in
//
//            print("로그인 성공")
//        }) { (error) in
//            self.simpleAlert(title: "로그인 실패", message: "로그인에 실패했습니다.")
//        }
    }
    
    // 회원가입 화면으로
    @IBAction func goToSignupAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC {
            present(vc, animated: true)
        }
    }
}

extension LoginVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.idTxt {
            if textField.text != "" {
                idCircleImage.isHidden = false
            }
            else {
                idCircleImage.isHidden = true
            }
        }
        else if textField == self.pwTxt {
            if textField.text != "" {
                pwCircleImage.isHidden = false
            }
            else {
                pwCircleImage.isHidden = true
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
