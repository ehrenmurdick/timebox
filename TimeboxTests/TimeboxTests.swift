//
//  TimeboxTests.swift
//  TimeboxTests
//
//  Created by Ehren Murdick on 4/11/16.
//  Copyright © 2016 Ehren Murdick. All rights reserved.
//

import XCTest
@testable import Timebox

class TimeboxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimerCoding() {
        let timer = Timer(startTime: NSDate(), savedDuration: 100, name: "hoobajoob")
        let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(timer)
        
        let newTimer = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Timer
        
        XCTAssertEqual(timer.name, newTimer!.name)
    }
}
