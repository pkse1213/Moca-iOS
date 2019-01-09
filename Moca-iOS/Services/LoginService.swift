//
//  LoginJoinService.swift
//  Moca-iOS
//
//  Created by 조수민 on 07/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import Alamofire

struct LoginService : APIService, RequestService {
    
    static let shared = LoginService()
    typealias NetworkData = AccountData
    let loginUrl = url("/login")
    let signupUrl = url("/user")
    let header: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    func login(body : [String:String], completion : @escaping(Token) -> Void, error : @escaping(Int) -> Void) {
        postable(loginUrl, body: body, header: header) { (res) in
            switch res {
            case .success(let accountData):
                let data = accountData.data
                completion(data!)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

