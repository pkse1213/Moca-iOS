//
//  CafeDetailReviewService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CafeDetailReviewService: APIService, RequestService {
    static let shareInstance = CafeDetailReviewService()
    let URL = url("/review")
    typealias NetworkData = CommunityReviewData
    
    func getCafeDetailReview(cafeId: Int, token: String, completion: @escaping ([CommunityReview]) -> Void, error: @escaping (Int) -> Void) {
        let reviewURL = URL + "/\(cafeId)/best"
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
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
