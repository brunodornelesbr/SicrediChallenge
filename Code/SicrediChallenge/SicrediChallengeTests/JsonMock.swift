//
//  JsonMock.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import Foundation
@testable import SicrediChallenge

struct JsonMock {
    static let jsonEventRequest : [String : Any] = [EventJsonConstants.id.rawValue : "1", EventJsonConstants.title.rawValue : "Feira", EventJsonConstants.price.rawValue : Double(exactly: 10),EventJsonConstants.latitude.rawValue : "50", EventJsonConstants.longitude.rawValue : "60",EventJsonConstants.description.rawValue : "Descricao",EventJsonConstants.date.rawValue : "1534784400000", EventJsonConstants.people.rawValue : [[PersonJsonConstants.id.rawValue:"0",PersonJsonConstants.eventId.rawValue : "1",PersonJsonConstants.name.rawValue : "Name",PersonJsonConstants.picture.rawValue :"pictureURL"]]]
}
