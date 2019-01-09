//
//  CommunityUserService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityUserService: APIService, RequestService {
    
    static let shareInstance = CommunityUserService()
    let URL = url("/user")
    typealias NetworkData = CommunityUserData
    
    func getUser(userId: String, token: String, completion: @escaping (CommunityUser) -> Void, error: @escaping (Int) -> Void) {
        let userURL = URL + "/\(userId)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(userURL, body: nil, header: header) { res in
            switch res {
            case .success(let CommunityUserData):
                print(CommunityUserData.message)
                let data = CommunityUserData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
