//
//  Global Functions Tests.swift
//  Mia_ExampleTests
//
//  Created by Michael Hedaitulla on 2/17/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Mia

class Global_Functions_Tests: XCTestCase {
    
    /// Get a thread-local date formatter object
    func getThreadLocalRFC3339DateFormatter() -> DateFormatter {
        return localThreadSingleton(key: "io.multinerd.RFC3339DateFormatter") {
            print("This block will only be executed once")

            let rfc3339DateFormatter = DateFormatter()
            rfc3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
            rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
            rfc3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            return rfc3339DateFormatter
        }
    }
    
    
    
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
    }
    
    func testThreadSingleton() {
        
        let x1 = getThreadLocalRFC3339DateFormatter()
        let x2 = getThreadLocalRFC3339DateFormatter()
        let x3 = getThreadLocalRFC3339DateFormatter()
        
        XCTAssertFalse(x1 === x2 && x2 === x3, "Cacheing objects failed")
    }
    
    
    

    


    
    
}
