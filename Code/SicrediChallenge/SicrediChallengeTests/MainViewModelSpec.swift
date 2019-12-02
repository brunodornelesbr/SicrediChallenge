//
//  MainViewModelSpec.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 02/12/19.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import SicrediChallenge
class  MainViewModelSpec : QuickSpec {
    override func spec() {
        describe("MainViewModel"){
            let mainViewModel = MainViewModel()
            var stub = RequestStub()
            mainViewModel.request = stub
            context("when requesting events an has an error"){
                stub.prepareRequestToReturnAnError()
                mainViewModel.requestEvents()
                it("should set an error"){
                    expect(mainViewModel.error.value).toNot(beNil())
                }
            }
            context("when searching for events after requesting events"){
                mainViewModel.requestEvents()
                mainViewModel.searchEvents(searchText: "N")
                it("should set search for the events that has N in them"){
                    expect(mainViewModel.events.value.count).toEventually(equal(1))
                }
            }
            
        }
    }
    
    
    
    
    
}
