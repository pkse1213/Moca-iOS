//
//  MyPageCheckService.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct MyPageCheckService : APIService, RequestService {
    
    typealias NetworkData = MyPageResponse
    static let shared = MyPageCheckService()
    let baseUrl = url("/user")
    
    // 회원 조회
    func getMyPageData(token : String, user_id : String, completion : @escaping(MyPageData) -> Void, error : @escaping(Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        
        let myPageUrl = baseUrl + "/\(user_id)/mypage"
        
        gettable(myPageUrl, body: nil, header: header) { (res) in
            switch res {
            case .success(let MyPageData):
                let data = MyPageData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
