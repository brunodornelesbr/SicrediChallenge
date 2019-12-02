//
//  MainViewModelStub.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 02/12/19.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
@testable import SicrediChallenge
class MainViewModelStub: MainViewModel {
    var didCallRequestEvents = false
    var didCallResultsEvents = false
    
    func generateValueForEventObservable(){
        events.value = [Event()]
    }
    override func requestEvents() {
        didCallRequestEvents = true
    }
    
    override func searchEvents(searchText: String) {
        didCallResultsEvents = true
        super.searchEvents(searchText: searchText)
    }
}
