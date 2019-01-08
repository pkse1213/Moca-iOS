//
//  CommunityFollowService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityFollowService: APIService, RequestService{
    
    static let shareInstance = CommunityFollowService()
    let URL = url("/user")
    typealias NetworkData = ResponseData
    
    func postFollow(userId: String, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let likeURL = URL + "/\(userId)/follow"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        postable(likeURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let data):
                completion(data.message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

