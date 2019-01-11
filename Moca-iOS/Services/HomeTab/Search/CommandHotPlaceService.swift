//
//  CommandHotPlaceService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RecommendHotPlaceService: APIService, RequestService {
    
    static let shareInstance = RecommendHotPlaceService()
    let URL = url("/hot_place/best")
    typealias NetworkData = RecommendHotPlaceData
    
    func getCommandHotPlace(token: String, completion: @escaping ([RecommendHotPlace]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(URL, body: nil, header: header) { res in
            switch res {
            case .success(let RecommendHotPlaceData):
                print(RecommendHotPlaceData.message)
                let data = RecommendHotPlaceData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
