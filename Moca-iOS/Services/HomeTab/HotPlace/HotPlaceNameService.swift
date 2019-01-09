//
//  HotPlaceService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 9..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct HotPlaceNameService: APIService, RequestService {
    
    static let shareInstance = HotPlaceNameService()
    let URL = url("/hot_place")
    typealias NetworkData = HotPlaceNameData
    
    func getRankingCafe(token: String, completion: @escaping ([HotPlaceName]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(URL, body: nil, header: header) { res in
            switch res {
            case .success(let HotPlaceNameData):
                print(HotPlaceNameData.message)
                let data = HotPlaceNameData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
