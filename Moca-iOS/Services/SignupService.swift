//
//  SignupService.swift
//  Moca-iOS
//
//  Created by 조수민 on 08/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct SignupService : APIService, RequestService {
    
    static let shared = SignupService()
    typealias NetworkData = AccountData
    let signupUrl = url("/user")
    let header: HTTPHeaders = [
        "Content-Type": "multipart/form-data"
    ]
    
    func signup(user_id: String, user_password: String, user_name: String, user_phone : String, user_img : UIImage, completion: @escaping () -> Void) {
        
        
//        Alamofire.upload(multipartFormData: { (multipart) in
//            multipart.append(user_id.data(using: .utf8)!, withName: "user_id")
//            multipart.append(user_password.data(using: .utf8)!, withName: "user_password")
//            multipart.append(user_name.data(using: .utf8)!, withName: "user_name")
//            multipart.append(user_phone.data(using: .utf8)!, withName: "user_phone")
//            multipart.append(user_img.jpegData(compressionQuality: 0.5)!, withName: "user_img", fileName: "image.jpeg", mimeType: "image/jpeg")
//        }, to: signupUrl,
//           headers: header) { (result) in
//
//            //멀티파트로 성공적으로 인코딩 되었다면 success, 아니라면 failure 입니다.
//            switch result {
//            case .success(let _, _, _):
//                print("join success")
//
//                completion()
//
//            case .failure(let err):
//                print(err)
//                completion()
//            }
//        }
//
        
        //
        Alamofire.upload(multipartFormData : { multipartFormData in
            
            //멀티파트를 이용해 데이터를 담습니다
            
            multipartFormData.append(user_id.data(using: .utf8)!, withName: "user_id")
            multipartFormData.append(user_password.data(using: .utf8)!, withName: "user_password")
            multipartFormData.append(user_name.data(using: .utf8)!, withName: "user_name")
            multipartFormData.append(user_phone.data(using: .utf8)!, withName: "user_phone")
            multipartFormData.append(user_img.jpegData(compressionQuality: 0.5)!, withName: "user_img", fileName: "user_img.jpeg", mimeType: "image/jpeg")
            
        },
                         to: signupUrl,
                         headers: header,
                         encodingCompletion: { encodingResult in
                            
                            switch encodingResult{
                            case .success(let upload, _, _):
                                upload.responseData { res in
                                    switch res.result {
                                    case .success:
                                        DispatchQueue.main.async(execute: {
                                            print("successㅜㅜ")
                                        })
                                    case .failure(let err):
                                        print("upload Error : \(err)")
                                        DispatchQueue.main.async(execute: {
                                            
                                        })
                                    }
                                }
                            case .failure(let err):
                                print("network Error : \(err)")
                            }//switch
        }
            
        )//Alamofire.upload
        
    }
    
}

