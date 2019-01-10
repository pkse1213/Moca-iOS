//
//  BestReview.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct BestReviewService: APIService, RequestService {
    
    static let shareInstance = BestReviewService()
    let URL = url("/cafe/best")
    typealias NetworkData = BestCafeData
    
    func getBestReview(flag: Int, token: String, completion: @escaping ([BestCafe]) -> Void, error: @escaping (Int) -> Void) {
        let reviewURL = URL + "/\(flag)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(reviewURL, body: nil, header: header) { res in
            switch res {
            case .success(let BestReviewData):
                print(BestReviewData.message)
                let data = BestReviewData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
