//
//  CommunityReviewSearchService.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityReviewSearchService: APIService, RequestService {
    
    static let shared = CommunityReviewSearchService()
    let URL = url("/search/cafe")
    typealias NetworkData = CommunityReviewSearchData
    
    func getReviewSearchResult(keyword : String, completion: @escaping ([CommunityReviewSearchResult]) -> Void, error: @escaping (Int) -> Void) {
        var searchUrl = URL + "/\(keyword)"
        
        searchUrl = searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        gettable(searchUrl, body: nil, header: nil) { (res) in
            switch res {
            case .success(let CommunityReviewSearchData) :
                let data = CommunityReviewSearchData.data
                completion(data)
            case .successWithNil(_) :
                break
            case .error(let errCode) :
                print("error123123")
                error(errCode)
            }
        }
    }
}
