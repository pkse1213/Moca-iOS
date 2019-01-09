//
//  MocaPicksDetailService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MocaPicksDetailService: APIService, RequestService {
    
    static let shareInstance = MocaPicksDetailService()
    let URL = url("/cafe/pick")
    typealias NetworkData = MocaPicksDetailData
    
    func getMocaPicksCafe(cafeId: Int, token: String, completion: @escaping (MocaPicksDetail) -> Void, error: @escaping (Int) -> Void) {
        let mocaPicksURL = URL + "/\(cafeId)/detail"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(mocaPicksURL, body: nil, header: header) { res in
            switch res {
            case .success(let MocaPicksDetailData):
                print(MocaPicksDetailData.message)
                let data = MocaPicksDetailData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
