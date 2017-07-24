import XCTest
import Mia

class Mia_RosewoodTests: XCTestCase {
    
    func testRosewoodLog() -> Void {

        Rosewood.verbose("Who am I?: ", self)
        Rosewood.debug("1 + 1 = ", 1 + 1)
        Rosewood.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.warning(1, 2, "3", separator: " - ")
        Rosewood.error("Error: ", NSError.init(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
        Thread.sleep(forTimeInterval: 1.0)
        
        Rosewood.Configuration.formatter = .oneline
        Rosewood.verbose("Who am I?: ", self)
        Rosewood.debug("1 + 1 = ", 1 + 1)
        Rosewood.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.warning(1, 2, "3", separator: " - ")
        Rosewood.error("Error: ", NSError.init(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
        Thread.sleep(forTimeInterval: 1.0)
        
        Rosewood.Configuration.formatter = .detailed
        Rosewood.verbose("Who am I?: ", self)
        Rosewood.debug("1 + 1 = ", 1 + 1)
        Rosewood.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.warning(1, 2, "3", separator: " - ")
        Rosewood.error("Error: ", NSError.init(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    func testRosewoodPrettyPrint() -> Void {
        
        Rosewood.prettyprint(nil)
        Rosewood.prettyprint(Int(5))
        Rosewood.prettyprint(Double(5.0))
        Rosewood.prettyprint(Float(2.0))
        Rosewood.prettyprint(String("Hello"))
        Rosewood.prettyprint(Bool(true))
        
        Rosewood.prettyprint(["Hello", "World"])
        Rosewood.prettyprint(["Hello": "World", "Number": 0])
        Rosewood.prettyprint(NSError(domain: "Hello, World!", code: 404, userInfo: ["Hello": "World", "Number": 0]))
        //        rosewood.prettyprint(Bool(true)) // NSObject
        
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    
    
        var count = 0
    
        func longtask() -> Void {
    
            count += 1
            if count % 2 == 0 {
                Thread.sleep(forTimeInterval: 0.25)
            } else {
                Thread.sleep(forTimeInterval: 0.5)
            }
        }
    
    
        func testRosewoodBenchmark() -> Void {

            Rosewood.benchmark("Tough Math 1", block: longtask)
    
            Rosewood.benchmark("Tough Math 10", iterations: 5, block: longtask)
    
            Rosewood.benchmark("Tough Math Inline", block: {
                longtask()
                Rosewood.benchmarkLog(message: "Hello", includeTimeStamp: true)
                longtask()
                longtask()
                longtask()
                Rosewood.benchmarkLog(message: "Hi", includeTimeStamp: true)
                longtask()
            })
    
            Thread.sleep(forTimeInterval: 1.0)
    
        }
    
    
}

