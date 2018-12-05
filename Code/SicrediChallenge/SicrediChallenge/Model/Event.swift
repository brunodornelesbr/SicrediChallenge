//
//  ListOfEventsRequest.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import ObjectMapper
class Event: Mappable {
    var id = "0"
    var title = "No Title"
    var price : Double = 0.0
    var latitude = "0.0"
    var longitude = "0.0"
    var description = ""
    var date = "1534784400000"
    var people = [Person]()
    var discount : [Discount]?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id<-map[EventJsonConstants.id.rawValue]
        title<-map[EventJsonConstants.title.rawValue]
        price<-map[EventJsonConstants.price.rawValue]
        latitude<-map[EventJsonConstants.latitude.rawValue]
        longitude<-map[EventJsonConstants.longitude.rawValue]
        description<-map[EventJsonConstants.description.rawValue]
        date<-map[EventJsonConstants.date.rawValue]
        people<-map[EventJsonConstants.people.rawValue]
        discount<-map[EventJsonConstants.discount.rawValue]
        }
}
