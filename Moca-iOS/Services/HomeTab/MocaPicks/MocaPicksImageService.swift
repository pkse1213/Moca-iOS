//
//  MocaPicksImageService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 11..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MocaPicksImageService: APIService, RequestService {
    
    static let shareInstance = MocaPicksImageService()
    let URL = url("/cafe/pick")
    typealias NetworkData = MocaPicksImageData
    
    func getMocaPicksImage(cafeId: Int, token: String, completion: @escaping ([MocaPicksImage]) -> Void, error: @escaping (Int) -> Void) {
        let mocaPicksURL = URL + "/\(cafeId)/image"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(mocaPicksURL, body: nil, header: header) { res in
            switch res {
            case .success(let MocaPicksImageData):
                print(MocaPicksImageData.message)
                let data = MocaPicksImageData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
