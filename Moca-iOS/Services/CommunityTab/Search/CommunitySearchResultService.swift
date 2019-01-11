//
//  CommunitySearchResultService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunitySearchResultService: APIService, RequestService {
    
    static let shareInstance = CommunitySearchResultService()
    let URL = url("/search/community")
    typealias NetworkData = CommunitySearchResultData
    
    func getHomeSearchResult(keyword: String, token: String, completion: @escaping (CommunitySearchResult) -> Void, error: @escaping (Int) -> Void) {
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
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
