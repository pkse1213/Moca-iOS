//
//  CommunityReviewDetailService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityReviewDetailService: APIService, RequestService {
    
    static let shareInstance = CommunityReviewDetailService()
    let URL = url("/review")
    typealias NetworkData = CommunityReviewDetailData
    
    func getReviewDetail(reviewId: Int, token: String, completion: @escaping (CommunityReview) -> Void, error: @escaping (Int) -> Void) {
        let reviewURL = URL + "/\(reviewId)/detail"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(reviewURL, body: nil, header: header) { res in
            switch res {
            case .success(let CommunityReviewDetailData):
                print(CommunityReviewDetailData.message)
                let data = CommunityReviewDetailData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
