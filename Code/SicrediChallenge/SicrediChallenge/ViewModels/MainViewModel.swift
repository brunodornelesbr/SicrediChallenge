//
//  MainViewModel.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import RxSwift
class MainViewModel: NSObject {
    private var events = Variable<[Event]>([])
    private var error = Variable<Error?>(nil)
    private var request = Request()
    
    //MARK:- PUBLIC OBSERVABLES
    var eventObservable :Observable<[Event]>{return events.asObservable()}
    var errorObservable : Observable<Error?>{return error.asObservable()}
    
    func requestEvents(){
        request.requestEvents(completion: {[weak self](response,error) in
            guard  error == nil else { self?.error.value = RequestError.badRequestError
                return
            }
     
            self?.events.value = response
        })
    }
    
    func searchEvents(searchText: String){
        events.value = events.value.filter {event in
        return   event.title.lowercased().contains(searchText.lowercased())
    }
    }
    
    func eventForRow(row: Int)->Event{
        return events.value[row]
    }
}
