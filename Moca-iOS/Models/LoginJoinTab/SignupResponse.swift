//
//  SignupResponse.swift
//  Moca-iOS
//
//  Created by 조수민 on 08/01/2019.
//  Copyright © 2019 박세은. All rights reserved.
//

import Foundation
import ObjectMapper

class SignupResponse : Codable {
    var status : Int
    var message : String
}
