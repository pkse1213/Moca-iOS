//
//  HomeSearchResultService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct HomeSearchResultService: APIService, RequestService {
    
    static let shareInstance = HomeSearchResultService()
    let URL = url("/search/cafe")
    typealias NetworkData = HomeSearchResultData
    
    func getHomeSearchResult(keyword: String, token: String, completion: @escaping ([HomeSearchResult]) -> Void, error: @escaping (Int) -> Void) {
        var searchURL = URL + "/\(keyword)"
        searchURL = searchURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(searchURL, body: nil, header: header) { res in
            switch res {
            case .success(let HomeSearchResultData):
                print(HomeSearchResultData.message)
                let data = HomeSearchResultData.data
                completion(data)
            case .successWithNil(_):
                completion([])
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
