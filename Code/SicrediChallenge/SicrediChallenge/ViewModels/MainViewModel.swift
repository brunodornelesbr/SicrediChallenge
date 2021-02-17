//
//  MainViewModel.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import RxSwift

class MainViewModel {
    internal var events = Variable<[Event]>([])
    internal var error = Variable<Error?>(nil)
    internal var request = Request()
    
    //MARK:- PUBLIC OBSERVABLES
    public var eventObservable: Observable<[Event]>{
        return events.asObservable()
    }
    public var errorObservable: Observable<Error?> {
        return error.asObservable()
    }
    
    public func requestEvents() {
        request.requestEvents(completion: {[weak self](response,error) in
            guard  error == nil else { self?.error.value = RequestError.badRequestError
                return
            }
            self?.events.value = response
        })
    }
    
    public func searchEvents(searchText: String) {
        events.value = events.value.filter {event in
        return   event.title.lowercased().contains(searchText.lowercased())
    }
    }
    
    public func eventForRow(row: Int)-> Event {
        return events.value[row]
    }
}
