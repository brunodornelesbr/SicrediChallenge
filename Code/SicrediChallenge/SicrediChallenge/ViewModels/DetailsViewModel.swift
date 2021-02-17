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
    private var eventVariable: Variable<Event>!
    private var isLoadingMoreInfo = Variable(false)
    private var error = Variable<Error?>(nil)
    private var isCheckinOk = Variable(false)

    private var request = Request()
    
    //MARK:- PUBLIC OBSERVABLES
    public var titleObservable: Observable<Event>{
        return eventVariable.asObservable()
    }
    public var errorObservable: Observable<Error?>{
        return error.asObservable()
    }
    public var loadingObservable: Observable<Bool>{
        return isLoadingMoreInfo.asObservable()
    }
    public var checkinObservable: Observable<Bool>{
        return isCheckinOk.asObservable()
    }

    init(event: Event) {
        eventVariable = Variable(event)
        loadMoreInfo()
    }
    
    public func loadMoreInfo() {
        isLoadingMoreInfo.value = true
        request.requestMoreInfo(eventId: eventVariable.value.id, completion: {[weak self](response,error) in
            guard error == nil || response != nil else
            { self?.error.value = RequestError.badRequestError
                return
            }
            self?.eventVariable.value = response!
            self?.isLoadingMoreInfo.value = false
                    }
        )
    }
    
    public func peopleCount()-> Int {
        return eventVariable.value.people.count
    }
    
    public func requestPersonForRow(index: Int)-> Person {
        return eventVariable.value.people[index]
    }
    
    public func textToShare()-> [String] {
        return ["\(eventVariable.value.title) : \(eventVariable.value.description)"]
    }

    public func checkin(email: String?, name: String?) {
        guard let emailSafe = email , let nameSafe = name else {error.value = RequestError.badEmail
            return
        }
        request.postCheckIn(name: nameSafe, email: emailSafe, eventId: eventVariable.value.id, completion: {[weak self] (response,error) in
            guard error == nil || response != nil else
            { self?.error.value = RequestError.badRequestError
                return
            }
            if response!.code == 200 {
                self?.isCheckinOk.value = true
            } else {self?.error.value = RequestError.badRequestError}
        })
        
    }
}
