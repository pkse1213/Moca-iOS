//
//  KakaoAddressService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct KakaoAddressService: APIService, RequestService {
    static let shareInstance = KakaoAddressService()
    let kakaoURL = "https://dapi.kakao.com/v2/local/search/keyword.json"
    let header: HTTPHeaders = [
        "Authorization" : "KakaoAK be22d1757eb2c241ad2f75618b968bae"
    ]
    typealias NetworkData = AddressData
    
    func searchAddressWithKeyword(query: String, completion: @escaping ([Address]) -> Void, error: @escaping (Int) -> Void) {
        let url = kakaoURL + "?query=\(query)"
        guard let searchURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(searchURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(AddressData.self, from: value)
                        completion(data.documents)
                    } catch {
                        print("decoding err")
                    }
                }
            case .failure(let err):
                print(err)
                
            }
        }
    }
    
}
