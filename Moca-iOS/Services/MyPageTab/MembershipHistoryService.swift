//
//  MembershipHistoryService.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct MembershipHistoryService : APIService, RequestService {
    
    typealias NetworkData = MembershipHistoryResponse
    static let shared = MembershipHistoryService()
    let baseUrl = url("/membership/history")
    
    // 멤버십
    func getMembershipHistory(token : String, completion : @escaping([MembershipHistoryData]) -> Void, error : @escaping(Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        
        gettable(baseUrl, body: nil, header: header) { (res) in
            switch res {
            case .success(let MembershipHistoryResponse):
                let data = MembershipHistoryResponse.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
