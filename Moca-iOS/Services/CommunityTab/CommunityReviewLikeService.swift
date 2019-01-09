//
//  ReviewLikeService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityReviewLikeService: APIService, RequestService{
    
    static let shareInstance = CommunityReviewLikeService()
    let URL = url("/review")
    typealias NetworkData = ResponseData
    
    func postLike(reviewId: Int, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        print(reviewId)
        let likeURL = URL + "/\(reviewId)/like"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        postable(likeURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let data):
                print(data.message)
                completion(data.message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

