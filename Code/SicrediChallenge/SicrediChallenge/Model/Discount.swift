//
//  Discount.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import ObjectMapper
class Discount: Mappable {
    var id = "0"
    var discount : Int = 0
    var eventId = "0"
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id<-map[DiscountJsonConstants.id.rawValue]
        discount<-map[DiscountJsonConstants.discount.rawValue]
        eventId<-map[DiscountJsonConstants.eventId.rawValue]


    }
}
