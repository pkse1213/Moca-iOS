//
//  RankingCafeService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RankingCafeService: APIService, RequestService {
    
    static let shareInstance = RankingCafeService()
    let URL = url("/cafe")
    typealias NetworkData = RankingCafeData
    
    func getRankingCafe(length: Int, token: String, completion: @escaping ([RankingCafe]) -> Void, error: @escaping (Int) -> Void) {
        let rankingURL = URL + "/ranking/\(length)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(rankingURL, body: nil, header: header) { res in
            switch res {
            case .success(let RankingCafeData):
                print(RankingCafeData.message)
                let data = RankingCafeData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
