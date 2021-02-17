//
//  CheckInResponse.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import ObjectMapper

class CheckInResponse: Mappable {
    var code: Int =  0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        var stringCode = ""
        stringCode<-map[CheckInResponseJsonConstants.code.rawValue]
        code = Int(stringCode) ?? 0 
    }
}
