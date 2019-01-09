//
//  ScrapCafeData.swift
//  Moca-iOS
//
//  Created by 조수민 on 09/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

class ScrapCafeResponse : Mappable {
    var status : Int?
    var message : String?
//    var data : [ScrapCafeData]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
//        data <- map["data"]
    }
}

//struct ScrapCafeData : Mappable {
//
//
////    required init?(map: Map) {
////        <#code#>
////    }
////
////    mutating func mapping(map: Map) {
////        <#code#>
////    }
//
//}
