//
//  MyPageEditService.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct MyPageEditService : APIService, RequestService {
    
    typealias NetworkData = PostMyPageEditResponse
    static let shared = MyPageEditService()
    let baseUrl = url("/user/mypage")
    
    // 마이페이지 수정
    func postMyPageEdit(token : String, userName : String, userPassword : String, userPhone : String, userStatusComment : String, userImg : Data, completion : @escaping(MyPageEditData) -> Void, error : @escaping(Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(userName.data(using: .utf8)!, withName: "user_name")
            multipart.append(userPassword.data(using: .utf8)!, withName: "user_password")
            multipart.append(userPhone.data(using: .utf8)!, withName: "user_phone")
            multipart.append(userStatusComment.data(using: .utf8)!, withName: "user_status_comment")
            multipart.append(userImg, withName: "user_img", fileName: "user_img.jpeg", mimeType: "image/jpeg")
        }, to: baseUrl,
           headers: header) { (encodingResult) in
            
//            switch encodingResult{
//            case .success(let upload, _, _):
//                upload.responseData { res in
//                    switch res.result {
//                    case .success(let PostMyPageEditResponse):
//                        print("upload success")
//                        completion(PostMyPageEditResponse.)
//                    case .failure(let err):
//                        print("upload Error : \(err)")
//                        error(err as! Int)
//                    }
//                }
//            case .failure(let err):
//                print("network Error : \(err)")
//                break
//            }//switch
            
            switch encodingResult {
                
            case .success(let request, let streamingFromDisk, let streamFileURL):
                request.response(completionHandler: { (PostMyPageEditResponse) in
                    print("upload success")
                    
                })
            case .failure(_):
                print("upload fail")
            }
        }
        
    }
}
