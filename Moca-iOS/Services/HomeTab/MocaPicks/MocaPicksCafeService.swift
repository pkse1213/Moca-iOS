//
//  MocaPicksCafeService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MocaPicksCafeService: APIService, RequestService {
    
    static let shareInstance = MocaPicksCafeService()
    let URL = url("/cafe/pick")
    typealias NetworkData = MocaPicksData
    
    func getMocaPicksCafe(length: Int, token: String, completion: @escaping ([MocaPicks]) -> Void, error: @escaping (Int) -> Void) {
        let mocaPicksURL = URL + "/\(length)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(mocaPicksURL, body: nil, header: header) { res in
            switch res {
            case .success(let MocaPicksData):
                print(MocaPicksData.message)
                let data = MocaPicksData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
