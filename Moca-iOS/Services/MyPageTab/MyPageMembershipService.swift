//
//  MyPageMembershipService.swift
//  Moca-iOS
//
//  Created by 조수민 on 10/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct MyPageMembershipService : APIService, RequestService {
    
    typealias NetworkData = MembershipListResponse
    static let shared = MyPageMembershipService()
    let baseUrl = url("/membership")
    
    // 멤버십
    func getMembership(token : String, completion : @escaping([MembershipData]) -> Void, error : @escaping(Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : token ,
            "Content-Type" : "application/json"
        ]
        
        gettable(baseUrl, body: nil, header: header) { (res) in
            switch res {
            case .success(let MembershipData):
                let data = MembershipData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
