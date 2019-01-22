//
//  CafeDetailSignitureService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CafeDetailSignitureService: APIService, RequestService {
    
    static let shareInstance = CafeDetailSignitureService()
    let URL = url("/cafe")
    typealias NetworkData = CafeDetailSignitureData
    
    func getCafeDetailSigniture(cafeId: Int, token: String, completion: @escaping ([CafeDetailSigniture]) -> Void, error: @escaping (Int) -> Void) {
        let signitureURL = URL + "/\(cafeId)/signiture"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(signitureURL, body: nil, header: header) { res in
            switch res {
            case .success(let CafeDetailSignitureData):
                print(CafeDetailSignitureData.message)
                let data = CafeDetailSignitureData.data
                completion(data)
            case .successWithNil(_):
                completion([])
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
