//
//  RequestClassTest.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import SicrediChallenge
class RequestMock : Request{
    override func requestEvents(completion: @escaping ([Event], Error?) -> ()) {
        let event = Mapper<Event>().map(JSON: JsonMock.jsonEventRequest)
        var listOfEvent : [Event] = []
        if event != nil {
        listOfEvent.append(event!)
        }
        completion(listOfEvent, nil)
    }
    
    override func requestMoreInfo(eventId: String, completion: @escaping (Event?, Error?) -> ()) {
        let event = Mapper<Event>().map(JSON: JsonMock.jsonEventWithDiscount)
      
        completion(event, nil)
    }
}
class RequestClassTest: XCTestCase {
    var request : Request!
       override func setUp() {
       request = RequestMock()
    }
    
    
    func testRequestObjectMapperShouldWork(){
        request.requestEvents(completion: {(result,error) in
            XCTAssert(result.count>0, "Request failed!")
            let event = JsonMock.jsonEventRequest
            XCTAssert(result.first?.id == event[EventJsonConstants.id.rawValue] as? String, "id malformed")
            XCTAssert(result.first?.title == event[EventJsonConstants.title.rawValue] as? String, "title malformed")
            XCTAssert(result.first?.price == event[EventJsonConstants.price.rawValue] as? Double, "price malformed")
            XCTAssert(result.first?.latitude == event[EventJsonConstants.latitude.rawValue] as? String, "latitude malformed")
            XCTAssert(result.first?.longitude == event[EventJsonConstants.longitude.rawValue] as? String, "longitude malformed")
            XCTAssert(result.first?.description == event[EventJsonConstants.description.rawValue] as? String, "description malformed")
            XCTAssert(result.first?.date == event[EventJsonConstants.date.rawValue] as? String, "date malformed")
            XCTAssert(result.first?.discount == nil, "discount should be nil")
            
            let peopleArray = event[EventJsonConstants.people.rawValue] as! [[String : Any]]
            XCTAssert((result.first?.people.count ?? 0)>0, "People malformed!")
            XCTAssert(result.first?.people.first?.id == peopleArray.first?[PersonJsonConstants.id.rawValue]as? String, "person id malformed")
            XCTAssert(result.first?.people.first?.picture == peopleArray.first?[PersonJsonConstants.picture.rawValue]as? String, "person picture malformed")
            XCTAssert(result.first?.people.first?.eventId == peopleArray.first?[PersonJsonConstants.eventId.rawValue]as? String, "person eventId malformed")
            XCTAssert(result.first?.people.first?.name == peopleArray.first?[PersonJsonConstants.name.rawValue] as? String, "person name malformed")

        })
    }
    
    func testRequestMoreInfoObjectMapperShouldWork(){
        request.requestMoreInfo(eventId: "10" ,completion: {(result,error) in
            let event = JsonMock.jsonEventWithDiscount
            XCTAssert(result?.id == event[EventJsonConstants.id.rawValue] as? String, "id malformed")
            XCTAssert(result?.title == event[EventJsonConstants.title.rawValue] as? String, "title malformed")
            XCTAssert(result?.price == event[EventJsonConstants.price.rawValue] as? Double, "price malformed")
            XCTAssert(result?.latitude == event[EventJsonConstants.latitude.rawValue] as? String, "latitude malformed")
            XCTAssert(result?.longitude == event[EventJsonConstants.longitude.rawValue] as? String, "longitude malformed")
            XCTAssert(result?.description == event[EventJsonConstants.description.rawValue] as? String, "description malformed")
            XCTAssert(result?.date == event[EventJsonConstants.date.rawValue] as? String, "date malformed")
            XCTAssert(result?.discount != nil, "discount should NOT be nil")
            
            let peopleArray = event[EventJsonConstants.people.rawValue] as! [[String : Any]]
            XCTAssert((result?.people.count ?? 0)>0, "People malformed!")
            XCTAssert(result?.people.first?.id == peopleArray.first?[PersonJsonConstants.id.rawValue]as? String, "person id malformed")
            XCTAssert(result?.people.first?.picture == peopleArray.first?[PersonJsonConstants.picture.rawValue]as? String, "person picture malformed")
            XCTAssert(result?.people.first?.eventId == peopleArray.first?[PersonJsonConstants.eventId.rawValue]as? String, "person eventId malformed")
            XCTAssert(result?.people.first?.name == peopleArray.first?[PersonJsonConstants.name.rawValue] as? String, "person name malformed")
        })
    }
    
    func testCheckInWithBadEmail(){
        request.postCheckIn(name: "", email: "bruno@dorneles.com", eventId: "", completion: {(response,error) in
            XCTAssert(error != nil, "Should throw error because of bad email!")
        })
    }

}


