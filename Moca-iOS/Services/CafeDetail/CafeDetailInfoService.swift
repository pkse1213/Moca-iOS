//
//  CafeDetailInfoService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CafeDetailInfoService: APIService, RequestService {
    
    static let shareInstance = CafeDetailInfoService()
    let URL = url("/cafe")
    typealias NetworkData = CafeDetailInfoData
    
    func getCafeDetailInfo(cafeId: Int, token: String, completion: @escaping (CafeDetailInfo) -> Void, error: @escaping (Int) -> Void) {
        let infoURL = URL + "/\(cafeId)/detail"
        let header: HTTPHeaders = [
            "Authoirzation" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(infoURL, body: nil, header: header) { res in
            switch res {
            case .success(let CafeDetailInfoData):
                let data = CafeDetailInfoData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
