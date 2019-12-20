//
//  ClassifiedUITests.swift
//  ClassifiedUITests
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import XCTest

class ClassifiedUITests: XCTestCase {

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductActions() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let productCell = app.collectionViews.staticTexts["Product: Notebook"]
        
//        XCTAssertTrue(productCell.exists)
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: productCell, handler: nil)
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
//        app.navigationBars.searchFields["Search..."].tap()
        
//        sleep(5)
//        app.searchFields["Search..."].typeText("hat")
//        XCTAssert(app.staticTexts["Result found"].exists)
        
        productCell.tap()
        
    }


//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
