//
//  CategoryCafeService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CategoryCafeService: APIService, RequestService {
    
    static let shareInstance = CategoryCafeService()
    let URL = url("/category/location")
    typealias NetworkData = CategoryCafeData
    
    func getCategoryCafe(locationId: Int, parameter: [String: Any], token: String, completion: @escaping ([CategoryCafe]) -> Void, error: @escaping (Int) -> Void) {
        let cafeURL = URL + "/\(locationId)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(cafeURL, body: parameter, header: header) { res in
            switch res {
            case .success(let CategoryCafeData):
                let data = CategoryCafeData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
