//
//  HotPlaceListService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct HotPlaceListService: APIService, RequestService {
    
    static let shareInstance = HotPlaceListService()
    let URL = url("/cafe/hot_place")
    typealias NetworkData = HotPlaceCafeData
    
    func getHotPlaceList(hotPlaceId: Int, token: String, completion: @escaping ([HotPlaceCafe]) -> Void, error: @escaping (Int) -> Void) {
        let hotPlaceURL = URL + "/\(hotPlaceId)"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(hotPlaceURL, body: nil, header: header) { res in
            switch res {
            case .success(let HotPlaceCafeData):
                print(HotPlaceCafeData.message)
                let data = HotPlaceCafeData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
