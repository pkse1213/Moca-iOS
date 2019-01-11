//
//  MyPageService.swift
//  Moca-iOS
//
//  Created by 조수민 on 09/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct MyPageScrapService: APIService, RequestService {
    
    typealias NetworkData = ScrapCafeResponse
    static let shared = MyPageScrapService()
    let scrapUrl = url("/user/scrap")
    
    // 찜한 카페
    func getScrap(token : String, completion : @escaping([ScrapCafeData]) -> Void, error : @escaping(Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : token,
            "Content-Type" : "application/json"
        ]
        
        gettable(scrapUrl, body: nil, header: header) { (res) in
            switch res {
            case .success(let ScrapCafeResponse):
                let data = ScrapCafeResponse.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
