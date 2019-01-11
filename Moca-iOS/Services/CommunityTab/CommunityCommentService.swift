//
//  CommunityCommentService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 12..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityCommentService: APIService, RequestService{
    
    static let shareInstance = CommunityCommentService()
    let URL = url("/review/comment")
    typealias NetworkData = ResponseData
    
    func postWriteComment(reviewId: Int, token: String, content: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        let body: [String: Any] = [
            "review_id": reviewId,
            "content": content
        ]
        postable(URL, body: body, header: header) { (res) in
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

