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
    typealias NetworkData = SignupResponse
    let signupUrl = url("/user")
    let header: HTTPHeaders = [
        "Content-Type": "multipart/form-data"
    ]
    
    func signup(userId: String, userPassword: String, userName: String, userPhone : String, userImg : UIImage?, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        
        if (userImg != nil) {
            Alamofire.upload(multipartFormData: { (multipart) in
                multipart.append(userId.data(using: .utf8)!, withName: "user_id")
                multipart.append(userName.data(using: .utf8)!, withName: "user_name")
                multipart.append(userPhone.data(using: .utf8)!, withName: "user_phone")
                multipart.append(userImg!.jpegData(compressionQuality: 0.5)!, withName: "user_img", fileName: "user_img.jpeg", mimeType: "image/jpeg")
            }, to: signupUrl,
               headers: header) { (result) in
                
                //멀티파트로 성공적으로 인코딩 되었다면 success, 아니라면 failure 입니다.
                switch result {
                case .success(let upload, _, _):
                    
                    // 성공 하였다면 아래의 과정으로 응답 리스폰스에 대한 처리를 합니다.
                    // 여기부터는 request 함수와 동일합니다.
                    upload.response
                    
//                    upload.responseObject { (res: DataResponse<SignupResponse>) in
//                        switch res.result {
//                        case .success:
//                            completion()
//                        case .failure(let err):
//                            print(err)
//                        }
//                    }
                    
                case .failure(let err):
                    print(err)
                }
            }
        }
        
        
        
//
//        Alamofire.upload(multipartFormData: { (multipart) in
//            multipart.append(userId.data(using: .utf8)!, withName: "user_id")
//            multipart.append(userName.data(using: .utf8)!, withName: "user_name")
//            multipart.append(userPhone.data(using: .utf8)!, withName: "user_phone")
//            multipart.append(userImg.jpegData(compressionQuality: 0.5)!, withName: "user_img", fileName: "user_img.jpeg", mimeType: "image/jpeg")
//        }, to: signupUrl,
//           header: header) { (result) in
//
//            //멀티파트로 성공적으로 인코딩 되었다면 success, 아니라면 failure 입니다.
//            switch result {
//            case .success(let upload, _, _):
//
//                // 성공 하였다면 아래의 과정으로 응답 리스폰스에 대한 처리를 합니다.
//                // 여기부터는 request 함수와 동일합니다.
//
//
//            case .failure(let err):
//                print(err)
//            }
//        }
        
    }
    
}

