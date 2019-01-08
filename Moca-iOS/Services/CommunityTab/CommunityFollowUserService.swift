//
//  FollowUserService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityFollowUserService: APIService, RequestService {
    
    static let shareInstance = CommunityFollowUserService()
    let URL = url("/user")
    typealias NetworkData = CommunityFollowUserData
    
    func getReviewComment(userId: String, token: String, path: String, completion: @escaping ([FollowUser]) -> Void, error: @escaping (Int) -> Void) {
        let followURL = URL + "/\(userId)/\(path)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(followURL, body: nil, header: header) { res in
            switch res {
            case .success(let CommunityFollowUserData):
                let data = CommunityFollowUserData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

