//
//  SignupService.swift
//  Moca-iOS
//
//  Created by 조수민 on 08/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher
import UIKit

struct SignupService : APIService, RequestService {
    
    static let shared = SignupService()
    typealias NetworkData = SignupResponse
    let signupUrl = url("/user")
//    let headers: HTTPHeaders = [
//        "Content-Type": "multipart/form-data"
//    ]
    
    func signup(userId: String, userPassword: String, userName: String, userPhone : String, userImg : UIImage?, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        
        if (userImg == nil) {
            Alamofire.upload(multipartFormData: { (multipart) in
                multipart.append(userId.data(using: .utf8)!, withName: "user_id")
                multipart.append(userPassword.data(using: .utf8)!, withName: "user_password")
                multipart.append(userName.data(using: .utf8)!, withName: "user_name")
                multipart.append(userPhone.data(using: .utf8)!, withName: "user_phone")
            }, usingThreshold: UInt64.init(), to: signupUrl, method: .post, headers: nil) { (encodingResult) in
                print(encodingResult)
                
                switch encodingResult {
                case .failure(let err) :
                    print("network error : \(err)")
                    break
                case .success(let upload, _, _) :
                    upload.responseData(completionHandler: { (res) in
                        print("회원가입 성공여부")
                        
                        switch res.result {
                        case .success :
                            if let value =  res.result.value {
                                var status = JSON(value)["status"]
                                print("update 접근\(status)")
                                
                                
                                
                                do {
                                    let status = JSON(value)["status"]
                                    
                                    if status == 200 {
                                        let message = JSON(value)["message"].string
                                        print(message)
                                        
                                        
                                    }
                                }
                            }
                            completion()
                            
                        case .failure(let err) :
                            print(err.localizedDescription)
                            break
                        }
                        
                        
                    })
                }
            }
        }
        else {
            if let profileImg = userImg {
                let profileImageData = profileImg.jpegData(compressionQuality: 0.5)

                Alamofire.upload(multipartFormData: { (multipart) in
                    multipart.append(userId.data(using: .utf8)!, withName: "user_id")
                    multipart.append(userPassword.data(using: .utf8)!, withName: "user_password")
                    multipart.append(userName.data(using: .utf8)!, withName: "user_name")
                    multipart.append(userPhone.data(using: .utf8)!, withName: "user_phone")
                    multipart.append(profileImageData!, withName: "user_img", fileName: "photo.jpg", mimeType: "image/jpeg")
                }, usingThreshold: UInt64.init(), to: signupUrl, method: .post, headers: nil) { (encodingResult) in
                    print(encodingResult)

                    switch encodingResult {
                    case .failure(let err) :
                        print("network error : \(err)")
                        break
                    case .success(let upload, _, _) :
                        upload.responseData(completionHandler: { (res) in
                            print("회원가입 성공여부")

                            switch res.result {
                            case .success :
                                if let value =  res.result.value {
                                    var status = JSON(value)["status"]
                                    print("update 접근\(status)")



                                    do {
                                        let status = JSON(value)["status"]

                                        if status == 200 {
                                            let message = JSON(value)["message"].string
                                            print(message)


                                        }
                                    }
                                }
                                completion()

                            case .failure(let err) :
                                print(err.localizedDescription)
                                break
                            }


                        })
                    }
                }
            }
        }
    }
}

