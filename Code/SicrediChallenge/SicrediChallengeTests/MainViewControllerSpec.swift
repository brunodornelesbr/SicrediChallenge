//
//  MainViewControllerSpec.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 02/12/19.
//  Copyright © 2019 Bruno. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import SicrediChallenge
class  MainViewControllerSpec : QuickSpec {
    override func spec() {
        describe("MainViewController"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let mainViewController = storyboard.instantiateViewController(withIdentifier: "main") as! MainViewController
                           let mainStub = MainViewModelStub()
                           mainViewController.mainViewModel = mainStub
                           mainViewController.loadView()
            context("did load from storyboard"){
                mainViewController.viewDidLoad()
                it("should request data from server"){
                    expect(mainStub.didCallRequestEvents).toEventually(equal(true))
                }
            }
            context("did load, did appear and have data ready to be consumed") {
                 mainViewController.viewDidAppear(false)
                 mainStub.generateValueForEventObservable()
                it("should show records in the tableview") {
                    expect(mainViewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(1))
                }
            }
            context("did load, did appear and the user did type in the search bar"){
                mainViewController.searchFor(text: "N")
                it("should request results to the viewmodel "){
                    expect(mainStub.didCallResultsEvents).toEventually(equal(true))
                }
                it("should show results in the table view"){
                    expect(mainViewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(1))
                }
            }
        }
    }
}

