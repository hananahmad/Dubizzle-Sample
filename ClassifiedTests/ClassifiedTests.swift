//
//  ClassifiedTests.swift
//  ClassifiedTests
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import XCTest
@testable import Classified

class ClassifiedTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetProductsInvalidJSONReturnsError() {
        
        let expect = expectation(description: "Networking service executed well.")
        
        APIClient.sharedInstance.getProductsList(completionHandler: { (Result) in
            switch Result {
            case .success(let value):
                if let response = value as? Board {
                    XCTAssertTrue(!response.result!.isEmpty)
                } else {
                    XCTFail("Failure in Products listing api.")
                }
                expect.fulfill()
                
            case .failure(_):
                XCTFail("Failure in members listing api.")
            }
        })
        
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
