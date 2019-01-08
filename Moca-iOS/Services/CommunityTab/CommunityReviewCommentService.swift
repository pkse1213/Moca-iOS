//
//  CommunityReviewCommentService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityReviewCommentService: APIService, RequestService {
    
    static let shareInstance = CommunityReviewCommentService()
    let URL = url("/review")
    typealias NetworkData = CommunityReviewCommentData
    
    func getReviewComment(reviewId: Int, completion: @escaping ([ReviewComment]) -> Void, error: @escaping (Int) -> Void) {
        let commentURL = URL + "/\(reviewId)/comment"
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        gettable(commentURL, body: nil, header: header) { res in
            switch res {
            case .success(let CommunityReviewCommentData):
                let data = CommunityReviewCommentData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
