//
//  Request.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class Request: NSObject {

    func requestEvents(completion : @escaping([Event], Error?)->()) {
        let eventsURL = API.event_url
        Alamofire.request(eventsURL, method: .get, parameters: nil, headers:  nil).responseArray(completionHandler:{(response:DataResponse<[Event]>) in
            completion(response.result.value ?? [],response.error)
        })
        }

    func requestMoreInfo(eventId: String, completion: @escaping(Event?, Error?)->()) {
        let moreInfoURL = String(format:API.event_detail,eventId)
        Alamofire.request(moreInfoURL,method: .get, parameters : nil, headers : nil).responseObject(completionHandler:{(response:DataResponse<Event>) in
            completion(response.result.value,response.error)
        })}
    
    func postCheckIn(name: String, email: String, eventId: String, completion: @escaping(CheckInResponse?, Error?)->()) {

        let checkInURL = API.checkin_url
        if !email.isValidEmail(testStr: email){
            completion(nil,RequestError.badEmail)
        }

        let parameters = ["name": name, "email": email, "eventId": eventId]
        Alamofire.request(checkInURL,method: .post, parameters: parameters, headers:  nil).responseObject(completionHandler: {(response:DataResponse<CheckInResponse>) in
            completion(response.result.value,response.error)
        })}
}


enum RequestError: Error{
    case badEmail
    case badRequestError
}
