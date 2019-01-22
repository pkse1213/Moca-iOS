//
//  CommunityReviewService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 7..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityReviewService: APIService, RequestService {
    
    static let shareInstance = CommunityReviewService()
    let URL = url("/feed")
    typealias NetworkData = CommunityReviewData
    
    func getUserReview(userId: String, token: String, completion: @escaping ([CommunityReview]) -> Void, error: @escaping (Int) -> Void) {
        let reviewURL = URL + "/user/\(userId)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(reviewURL, body: nil, header: header) { res in
            switch res {
            case .success(let CommunityReviewData):
                print(CommunityReviewData.message)
                let data = CommunityReviewData.data
                completion(data)
            case .successWithNil(_):
                completion([])
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    func getSocialReview(token: String, completion: @escaping ([CommunityReview]) -> Void, error: @escaping (Int) -> Void) {
        let reviewURL = URL + "/social"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(reviewURL, body: nil, header: header) { res in
            switch res {
            case .success(let CommunityReviewData):
                print(CommunityReviewData.message)
                let data = CommunityReviewData.data
                completion(data)
            case .successWithNil(_):
                completion([])
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
