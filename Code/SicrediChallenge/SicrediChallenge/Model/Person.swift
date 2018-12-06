//
//  People.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import ObjectMapper

class Person: Mappable {
    var id = "0"
    var eventId = "0"
    var name = ""
    var picture = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id<-map[PersonJsonConstants.id.rawValue]
        eventId<-map[PersonJsonConstants.eventId.rawValue]
        name<-map[PersonJsonConstants.name.rawValue]
        picture<-map[PersonJsonConstants.picture.rawValue]
}
}
