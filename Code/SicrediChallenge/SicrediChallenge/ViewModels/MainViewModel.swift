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
     
            self?.events.value.append(contentsOf: response)
        })
    }
    
    
}
