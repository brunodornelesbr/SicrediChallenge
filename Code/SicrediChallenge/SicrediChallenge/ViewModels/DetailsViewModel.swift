//
//  DetailsViewModel.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 06/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import RxSwift
class DetailsViewModel {
    private var eventVariable : Variable<Event>!
    private var isLoadingMoreInfo = Variable(false)
    private var error = Variable<Error?>(nil)

    private var request = Request()
    //MARK:- PUBLIC OBSERVABLES
    var titleObservable : Observable<Event>{return eventVariable.asObservable()}
    var errorObservable : Observable<Error?>{return error.asObservable()}
    var loadingObservable : Observable<Bool>{return isLoadingMoreInfo.asObservable()}

    init(event: Event) {
        eventVariable = Variable(event)
        loadMoreInfo()
    }
    
    func loadMoreInfo(){
        isLoadingMoreInfo.value = true
        request.requestMoreInfo(eventId: eventVariable.value.id, completion: {[weak self](response,error) in
            guard error != nil || response == nil else
            { self?.error.value = RequestError.badRequestError
                return
            }
            
            self?.eventVariable.value = response!
                    }
        )
    }
    
    func peopleCount()->Int{return eventVariable.value.people.count}
    
    func requestPersonForRow(index : Int)->Person{
        return eventVariable.value.people[index]
    }
}
