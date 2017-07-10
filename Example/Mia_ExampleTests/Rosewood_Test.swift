import XCTest
import Mia

class Mia_RosewoodTests: XCTestCase {
    
    func testRosewoodLog() -> Void {
        
        let rosewood = Rosewood.shared
        
        //rosewood.verbose("Reset to ", nil)
        rosewood.verbose("Who am I?: ", self)
        rosewood.debug("1 + 1 = ", 1 + 1)
        rosewood.info("IsMainThread: ", Thread.current.isMainThread)
        rosewood.warning(1, 2, "3", separator: " - ")
        rosewood.error("Error: ", NSError.init(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
        Thread.sleep(forTimeInterval: 1.0)
        
        Rosewood.Configuration.formatter = .oneline
        rosewood.verbose("Who am I?: ", self)
        rosewood.debug("1 + 1 = ", 1 + 1)
        rosewood.info("IsMainThread: ", Thread.current.isMainThread)
        rosewood.warning(1, 2, "3", separator: " - ")
        rosewood.error("Error: ", NSError.init(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
        Thread.sleep(forTimeInterval: 1.0)
        
        Rosewood.Configuration.formatter = .detailed
        rosewood.verbose("Who am I?: ", self)
        rosewood.debug("1 + 1 = ", 1 + 1)
        rosewood.info("IsMainThread: ", Thread.current.isMainThread)
        rosewood.warning(1, 2, "3", separator: " - ")
        rosewood.error("Error: ", NSError.init(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    func testRosewoodPrettyPrint() -> Void {
        
        let rosewood = Rosewood.shared
        
        rosewood.prettyprint(nil)
        rosewood.prettyprint(Int(5))
        rosewood.prettyprint(Double(5.0))
        rosewood.prettyprint(Float(2.0))
        rosewood.prettyprint(String("Hello"))
        rosewood.prettyprint(Bool(true))
        
        rosewood.prettyprint(["Hello", "World"])
        rosewood.prettyprint(["Hello": "World", "Number": 0])
        rosewood.prettyprint(NSError(domain: "Hello, World!", code: 404, userInfo: ["Hello": "World", "Number": 0]))
        //        rosewood.prettyprint(Bool(true)) // NSObject
        
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
}

