/// Definition of a block that can be used for measurements
public typealias MeasuredBlock = ()->()

private var depth = 0

private var logs = [ String ]()

private var timingStack = [ (startTime: Double, name: String, reported: Bool) ]()

private var depthIndent: String {
    return String(repeating: "\t", count: depth)
}

private var now: Double {
    return Date().timeIntervalSinceReferenceDate
}




/// Define different styles of reporting
public enum MeasurementLogStyle{
    /// Don't measure anything
    case none
    
    /// Log results of measurements to the console
    case print
}

/// Provides static methods for performing measurements
public class Duration{
    private static var timingStack = [(startTime:Double,name:String,reported:Bool)]()
    
    private static var logStyleStack = [MeasurementLogStyle]()
    
    /// When you are releasing and want to turn off logging, and your library
    /// may be used by another, it is better to push/pop a logging state. This
    /// will ensure your settings do not impact those of other modules. By pushing
    /// your desired log style, and sub-sequently pop'ing before returning from
    /// your measured method only your desired measuremets will be logged.
    public static func pushLogStyle(style: MeasurementLogStyle) {
        logStyleStack.append(logStyle)
        logStyle = style
    }
    
    /// Pops the last pushed logging style and restores the logging style to
    /// its previous style
    public static func popLogStyle(){
        logStyle = logStyleStack.removeLast()
    }
    
    /// Set to control how measurements are reported. It is recommended to use
    /// `pushLogStyle` and `popLogStyle` if you intend to make your module
    /// available for others to use
    public static var logStyle = MeasurementLogStyle.print
    
    /// Ensures that if any parent measurement boundaries have not yet resulted
    /// in output that their headers are displayed
    private static func reportContaining() {
        if depth > 0 && logStyle == .print {
            for stackPointer in 0..<timingStack.count {
                let containingMeasurement = timingStack[stackPointer]
                
                if !containingMeasurement.reported {
                    print(String(repeating: "\t" + "Measuring \(containingMeasurement.name):", count: stackPointer))
                    timingStack[stackPointer] = (containingMeasurement.startTime,containingMeasurement.name,true)
                }
            }
        }
    }
    
    /// Start a measurement, call `stopMeasurement` when you have completed your
    /// desired operations. The `name` will be used to identify this specific
    /// measurement. Multiple calls will nest measurements within each other.
    public static func startMeasurement(_ name: String) {
        reportContaining()
        timingStack.append((now,name,false))
        
        depth += 1
    }
    
    /// Stops measuring and generates a log entry. Note if you wish to include
    /// additional information (for example, the number of items processed) then
    /// you can use the `stopMeasurement(executionDetails:String?)` version of
    /// the function.
    public static func stopMeasurement() -> Double {
        return stopMeasurement(nil)
    }
    
    /// Prints a message, optionally with a time stamp (measured from the
    /// start of the current measurement.
    public static func log(message:String, includeTimeStamp:Bool = false) {
        reportContaining()
        
        if includeTimeStamp{
            let currentTime = now
            
            let timeStamp = currentTime - timingStack[timingStack.count-1].startTime
            
            return print("\(depthIndent)\(message)  \(timeStamp.milliSeconds)ms")
        } else {
            return print("\(depthIndent)\(message)")
        }
    }
    
    /// Stop measuring operations and generate log entry.
    public static func stopMeasurement(_ executionDetails: String?) -> Double {
        let endTime = now
        precondition(depth > 0, "Attempt to stop a measurement when none has been started")
        
        let beginning = timingStack.removeLast()
        
        depth -= 1
        
        let took = endTime - beginning.startTime
        
        if logStyle == .print {
            print("\(depthIndent)\(beginning.name) took: \(took.milliSeconds)" + (executionDetails == nil ? "" : " (\(executionDetails!))"))
        }
        
        return took
    }
    
    ///
    ///  Calls a particular block measuring the time taken to complete the block.
    ///
    public static func measure(_ name: String, block: MeasuredBlock) -> Double {
        startMeasurement(name)
        block()
        return stopMeasurement()
    }
    
    ///
    /// Calls a particular block the specified number of times, returning the average
    /// number of seconds it took to complete the code. The time
    /// take for each iteration will be logged as well as the average time and
    /// standard deviation.
    public static func measure(name: String, iterations: Int = 10, forBlock block: MeasuredBlock) -> [String: Double] {
        precondition(iterations > 0, "Iterations must be a positive integer")
        
        var data: [String: Double] = [:]
        
        var total : Double = 0
        var samples = [Double]()
        
        if logStyle == .print {
            print("\(depthIndent)Measuring \(name)")
        }
        
        for i in 0..<iterations{
            let took = measure("Iteration \(i+1)",block: block)
            
            samples.append(took)
            
            total += took
            
            data["\(i+1)"] = took
        }
        
        let mean = total / Double(iterations)
        
        var deviation = 0.0
        
        for result in samples {
            
            let difference = result - mean
            
            deviation += difference*difference
        }
        
        let variance = deviation / Double(iterations)
        
        data["average"] = mean
        data["stddev"] = variance
        
        if logStyle == .print {
            print("\(depthIndent)\(name) Average", mean.milliSeconds)
            print("\(depthIndent)\(name) STD Dev.", variance.milliSeconds)
        }
        
        return data
    }
}



// MARK: - Double Extensions

extension Double {
    
    var milliSeconds: String {
        return String(format: "%03.2fms", self * 1000)
    }
    
}






//public class Duration {
//    
//    /// Calls a set of code the specified number of times, returning the average in the form of a dictionary.
//    ///
//    /// - Parameters:
//    ///   - name: The benchmark name.
//    ///   - iterations: The number of times to run code
//    ///   - block: The code to run
//    /// - Returns: Returns a dictionary with the time for each run.
//    public func benchmark(_ name: String, iterations: Int = 1, block: () -> ()) -> [String: Double] {
//        
//        guard Configuration.enabled else {
//            return [:]
//        }
//        
//        precondition(iterations > 0, "Iterations must be a positive integer")
//        
//        var data: [String: Double] = [:]
//        
//        var total: Double = 0
//        var samples = [ Double ]()
//        
//        printToDebugger("\n🖤Measure \(name)")
//        
//        if iterations == 1 {
//            let took = benchmark(name, forBlock: block).first!
//            
//            samples.append(took.value)
//            total += took.value
//            
//            data["1"] = took.value
//        } else {
//            for i in 0..<iterations {
//                let took = benchmark("Iteration \(i + 1)", forBlock: block).first!
//                
//                samples.append(took.value)
//                total += took.value
//                
//                data["\(i + 1)"] = took.value
//            }
//            
//            let average = total / Double(iterations)
//            var deviation = 0.0
//            for result in samples {
//                
//                let difference = result - average
//                deviation += difference * difference
//            }
//            
//            let variance = deviation / Double(iterations)
//            
//            printToDebugger("🖤\t- Total: \(total.milliSeconds)")
//            printToDebugger("🖤\t- Average: \(average.milliSeconds)")
//            printToDebugger("🖤\t- STD Dev: \(variance.milliSeconds)")
//            
//        }
//        
//        return data
//    }
//    
//    /// Prints a message with an optional timestamp from start of measurement.
//    ///
//    /// - Parameters:
//    ///   - message: The message to log.
//    ///   - includeTimeStamp: Bool value to show time.
//    public func benchmarkLog(message: String, includeTimeStamp: Bool = false) {
//        
//        reportContaining()
//        
//        if includeTimeStamp {
//            let currentTime = now
//            let timeStamp = currentTime - timingStack[timingStack.count - 1].startTime
//            
//            printToDebugger("🖤\(depthIndent)\(message)  \(timeStamp.milliSeconds)")
//        } else {
//            printToDebugger("🖤\(depthIndent)\(message)")
//        }
//    }
//    
//    
//    private func benchmark(_ name: String, forBlock block: () -> ()) -> [String: Double] {
//        
//        startBenchmark(name)
//        block()
//        
//        return stopBenchmark()
//    }
//    
//    
//    private func startBenchmark(_ name: String) {
//        
//        reportContaining()
//        timingStack.append((now, name, false))
//        depth += 1
//    }
//    
//    
//    private func stopBenchmark() -> [String: Double] {
//        
//        let endTime = now
//        precondition(depth > 0, "Attempt to stop a measurement when none has been started")
//        
//        let beginning = timingStack.removeLast()
//        depth -= 1
//        
//        let took = endTime - beginning.startTime
//        
//        let log = "🖤\(depthIndent)\(beginning.name): \(took.milliSeconds)"
//        printToDebugger(log)
//        
//        return [ log: took ]
//    }
//    
//    
//    private func reportContaining() {
//        
//        if depth > 0 && Configuration.enabled && .debug >= Configuration.minLevel {
//            for stackPointer in 0..<timingStack.count {
//                let containingMeasurement = timingStack[stackPointer]
//                
//                if !containingMeasurement.reported {
//                    //Swift.print(String(repeating: "\t" + "Measuring \(containingMeasurement.name):", count: stackPointer))
//                    timingStack[stackPointer] = (containingMeasurement.startTime, containingMeasurement.name, true)
//                }
//            }
//        }
//    }
//    
//}
