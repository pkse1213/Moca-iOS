//
//  MocaPlusContentService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MocaPlusContentService: APIService, RequestService {
    
    static let shareInstance = MocaPlusContentService()
    let URL = url("/plus")
    typealias NetworkData = MocaPlusContentData
    
    func getMocaPlusContents(plusId: Int, token: String, completion: @escaping ([MocaPlusContent]) -> Void, error: @escaping (Int) -> Void) {
        let plusURL = URL + "/\(plusId)/contents"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(plusURL, body: nil, header: header) { res in
            switch res {
            case .success(let MocaPlusContentData):
                print(MocaPlusContentData.message)
                let data = MocaPlusContentData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
