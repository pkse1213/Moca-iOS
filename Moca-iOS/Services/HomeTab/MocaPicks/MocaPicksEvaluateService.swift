//
//  MocaPicksEvaluateService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 11..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MocaPicksEvaluateService: APIService, RequestService {
    
    static let shareInstance = MocaPicksEvaluateService()
    let URL = url("/cafe/pick")
    typealias NetworkData = MocaPicksEvaluateData
    
    func getMocaPicksEvaluate(cafeId: Int, token: String, completion: @escaping ([MocaPicksEvaluate]) -> Void, error: @escaping (Int) -> Void) {
        let mocaPicksURL = URL + "/\(cafeId)/evaluate"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(mocaPicksURL, body: nil, header: header) { res in
            switch res {
            case .success(let MocaPicksEvaluateData):
                print(MocaPicksEvaluateData.message)
                let data = MocaPicksEvaluateData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
