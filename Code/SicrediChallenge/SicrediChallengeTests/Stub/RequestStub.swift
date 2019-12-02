//
//  RequestStub.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 02/12/19.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
@testable import SicrediChallenge
class RequestStub : Request {
    var shouldReturnErrorToRequest = false
    func prepareRequestToReturnAnError(){
        shouldReturnErrorToRequest = true
    }
    
    override func requestEvents(completion: @escaping ([Event], Error?) -> ()) {
        if shouldReturnErrorToRequest {
            completion([],RequestError.badRequestError)
            shouldReturnErrorToRequest = false
            return
        }
        
        let event1 = Event()
        event1.title = "Valor"
        let event2 = Event()
        event2.title = "Novo"
        completion([event1,event2],nil)
        return
    }
}
