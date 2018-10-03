//
//  EventPlannerTests.swift
//  EventPlannerTests
//
//  Created by Zaid Aslam Shaikh on 9/22/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import XCTest
@testable import EventPlanner
import CoreLocation
import UIKit

class EventPlannerTests: XCTestCase {
    
    
    var meet: MeetDetails  = MeetDetails()
    
    var list: ListController  = ListController()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       // XCTAssertNotNil(meet.index)
    }
    
    func testEventIndex() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
         XCTAssertNotNil(meet.index)
                }
    
    func testLocation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNil(list.currentLocation)
    }
    
    func testClientid() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertEqual(client_id, "FP3VYT1ZP3HE0GZAYPYTPLY1WC1341Q0SD4HZZ5BJHCP5WMS")
    }
    
    func testClientSecret() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(client_secret, "MB0JZYXEPDA2IT0FHVWPCCNVNJRMT0UV1TCVCHXCHR5EWX4N")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    
        
    }
    
}
