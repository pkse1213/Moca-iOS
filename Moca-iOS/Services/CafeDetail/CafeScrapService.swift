//
//  CafeScrapService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 7..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CafeScrapService: APIService, RequestService{
    
    static let shareInstance = CafeScrapService()
    let URL = url("/user")
    typealias NetworkData = ResponseData
    
    func postCafeScrap(cafeId: Int, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let scrapURL = URL + "/\(cafeId)/scrap"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        postable(scrapURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let data):
                print(data.message)
                completion(data.message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
        
    }
    
    func deleteCafeScrap(cafeId: Int, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let scrapURL = URL + "/\(cafeId)/scrap"
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        deletable(scrapURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let data):
                print(data.message)
                completion(data.message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
        
    }
    
}
