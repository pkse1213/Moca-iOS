//
//  BestUserService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct BestUserService: APIService, RequestService{
    
    static let shareInstance = BestUserService()
    let URL = url("/user/best")
    typealias NetworkData = BestUserData
    
    func getBestUser(token: String, completion: @escaping ([BestUser]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(URL, body: nil, header: header) { res in
            switch res {
            case .success(let BestUserService):
                print(BestUserService.message)
                let data = BestUserService.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
