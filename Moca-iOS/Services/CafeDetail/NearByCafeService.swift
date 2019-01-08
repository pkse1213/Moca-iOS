//
//  NearCafeService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NearByCafeService: APIService, RequestService{
    
    static let shareInstance = NearByCafeService()
    let URL = url("/cafe/nearbycafe")
    typealias NetworkData = NearByCafeData
    
    func getNearByCafe(isCafeDetail: Int, token: String, cafeId: Int, latitude: Double, longitude: Double, completion: @escaping ([NearByCafe]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        let body: [String: Any] = [
            "cafe_latitude": latitude,
            "cafe_longitude": longitude,
            "cafe_id" : cafeId,
            "is_cafe_detail" : isCafeDetail
        ]
        postable(URL, body: body, header: header) { (res) in
            switch res {
            case .success(let NearByCafeData):
                completion(NearByCafeData.data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
