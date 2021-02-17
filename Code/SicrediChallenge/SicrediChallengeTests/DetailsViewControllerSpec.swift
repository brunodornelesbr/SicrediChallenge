//
//  DetailsViewControllerSpec.swift
//  SicrediChallengeTests
//
//  Created by Bruno Dorneles on 02/12/19.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import SicrediChallenge
class DetailsViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("DetailsViewController"){
            context("did load from storyboard"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailsViewController = storyboard.instantiateViewController(withIdentifier: "detail") as! DetailsViewController
                
                detailsViewController.loadView()
                detailsViewController.detailsViewModel = DetailsViewModelStub(event: Event())
                detailsViewController.viewDidLoad()
                
                it("should create two cells for the tableview") {
                    expect(detailsViewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(2))
                }
            }
        }
    }
}
