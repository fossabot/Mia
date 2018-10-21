import XCTest
import Mia


class RosewoodTest: XCTestCase {

    let error = NSError(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ])
    
    var count = 0
    
    func longtask() -> Void {
        
        count += 1
        if count % 2 == 0 {
            Thread.sleep(forTimeInterval: 0.25)
        } else {
            Thread.sleep(forTimeInterval: 0.5)
        }
    }

    class func getUserID() -> String {
        return "User: 123"
    }
    
    
    
    func testRosewoodLogDefaultFormat() -> Void {
        
        Rosewood.Configuration.formatter = .default
        
        Rosewood.Log.verbose("Who am I?: ", self)
        Rosewood.Log.debug("1 + 1 = ", 1 + 1)
        Rosewood.Log.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.Log.warning(1, 2, "3")
        Rosewood.Log.error("Error: ", error)
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    func testRosewoodLogOneLineFormat() -> Void {
        
        Rosewood.Configuration.formatter = .oneLine
        
        Rosewood.Log.verbose("Who am I?: ", self)
        Rosewood.Log.debug("1 + 1 = ", 1 + 1)
        Rosewood.Log.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.Log.warning(1, 2, "3")
        Rosewood.Log.error("Error: ", error)
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    func testRosewoodLogDetailedFormat() -> Void {
        
        Rosewood.Configuration.formatter = .detailed
        
        Rosewood.Log.verbose("Who am I?: ", self)
        Rosewood.Log.debug("1 + 1 = ", 1 + 1)
        Rosewood.Log.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.Log.warning(1, 2, "3")
        Rosewood.Log.error("Error: ", error)
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    func testRosewoodogCustomFormat() -> Void {
        
        let short = RosewoodFormatter("%@: %@", [.level, .message])
        Rosewood.Configuration.formatter = short
        
        Rosewood.Log.verbose("Who am I?: ", self)
        Rosewood.Log.debug("1 + 1 = ", 1 + 1)
        Rosewood.Log.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.Log.warning(1, 2, "3")
        Rosewood.Log.error("Error: ", error)
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
    func testRosewoodLogBlockFormat() -> Void {
        
        let block = RosewoodFormatter("[%@] %@: %@", [.block(RosewoodTest.getUserID), .level, .message])
        Rosewood.Configuration.formatter = block
        
        Rosewood.Log.verbose("Who am I?: ", self)
        Rosewood.Log.debug("1 + 1 = ", 1 + 1)
        Rosewood.Log.info("IsMainThread: ", Thread.current.isMainThread)
        Rosewood.Log.warning(1, 2, "3")
        Rosewood.Log.error("Error: ", error)
        Thread.sleep(forTimeInterval: 1.0)
    
    }
    

    func testRosewoodPrettyPrint() -> Void {

        Rosewood.PrettyPrint.items(nil)
        return
            
        Rosewood.PrettyPrint.items(Int(5))
        Rosewood.PrettyPrint.items(Double(5.0))
        Rosewood.PrettyPrint.items(Float(2.0))
        Rosewood.PrettyPrint.items(String("Hello"))
        Rosewood.PrettyPrint.items(Bool(true))

        Rosewood.PrettyPrint.items([ "Hello", "World" ])
        Rosewood.PrettyPrint.items([ "Hello": "World", "Number": 0 ])
        Rosewood.PrettyPrint.items(error)

        Thread.sleep(forTimeInterval: 1.0)

    }


    func testRosewoodBenchmark() -> Void {

        Rosewood.Benchmark.task("Long calculations 1", block: longtask)

        Rosewood.Benchmark.task("Long calculations 10", iterations: 5, block: longtask)

        Rosewood.Benchmark.task("Long calculations Inline", block: {
            longtask()
            Rosewood.Benchmark.log(message: "Hello", includeTimeStamp: true)
            longtask()
            longtask()
            longtask()
            Rosewood.Benchmark.log(message: "Hi", includeTimeStamp: true)
            longtask()
        })

        Thread.sleep(forTimeInterval: 1.0)

    }

}

