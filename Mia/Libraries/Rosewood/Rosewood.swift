private let queue = DispatchQueue(label: "Multinerd.Rosewood")


// MARK: - Delegate
public protocol RosewoodDelegate: NSObjectProtocol {
    func rosewoodDidLog(message: String)
}


// MARK: - Rosewood
public struct Rosewood {

    // MARK: Delegate

    /// The logging delegate.
    public static weak var delegate: RosewoodDelegate?

    // MARK: Configuration

    /// The logging configurations.
    public struct Configuration {

        /// The logger state.
        public static var enabled: Bool = true

        /// The minimum level of severity.
        public static var minLevel: LogLevel = .verbose

        /// The logger formatter.
        public static var formatter: LogFormatter = .oneline

        /// The logger state.
        public static var isAsync: Bool = true

    }


    // MARK: Init/Deinit

    private init() {}


    // MARK: Private Methods

    fileprivate static func printToDebugger(_ message: String) -> Void {

        if Configuration.isAsync {
            queue.async {
                print(message)
                Rosewood.delegate?.rosewoodDidLog(message: message)
            }
        } else {
            queue.sync {
                print(message)
                Rosewood.delegate?.rosewoodDidLog(message: message)
            }
        }
    }

}


// MARK: - Rosewood Logging
extension Rosewood {

    // MARK: Public Methods

    /// Logs a message with a verbose severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - separator: The separator between the items.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func verbose(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {

        log(.verbose, items, separator, file, line, function)
    }


    /// Logs a message with a debug severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - separator: The separator between the items.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func debug(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {

        log(.debug, items, separator, file, line, function)
    }


    /// Logs a message with a info severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - separator: The separator between the items.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func info(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {

        log(.info, items, separator, file, line, function)
    }


    /// Logs a message with a warning severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - separator: The separator between the items.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func warning(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {

        log(.warning, items, separator, file, line, function)
    }


    /// Logs a message with a error severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - separator: The separator between the items.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func error(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {

        log(.error, items, separator, file, line, function)
    }


    // MARK: Private Methods

    private static func log(_ level: LogLevel, _ items: [Any], _ separator: String, _ file: String, _ line: Int, _ function: String) {

        guard Configuration.enabled && level >= Configuration.minLevel else {
            return
        }

        let result = Configuration.formatter.format(level: level, items: items, separator: separator, file: file, line: line, function: function)

        printToDebugger(result)
    }

}


// MARK: - Rosewood PrettyPrint
extension Rosewood {

    // MARK: Public Methods

    /// Prettyprint an item.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func prettyprint(_ items: Any?..., file: String = #file, line: Int = #line, function: String = #function) {

        for item in items {
            log(.pretty, item, file, line, function)
        }
    }


    // MARK: Private Methods

    private static func log(_ level: LogLevel, _ item: Any?, _ file: String, _ line: Int, _ function: String) {

        guard Configuration.enabled else {
            return
        }

        var type = "nil"
        var jsonString: String? = nil
        if let x = item {

            type = String(describing: Mirror(reflecting: x).subjectType)//.trimmingCharacters(in: CharacterSet.letters.inverted)

            switch x {
                case (is Int): break
                case (is Double): break
                case (is Float): break
                case (is String): break
                case (is Bool): break

                case (is NSArray):
                    jsonString = prettyPrint(NSObject.reflect(objects: x as! NSArray))
                    break

                case (is NSDictionary):
                    jsonString = prettyPrint(x) ?? "\n\(x)"
                    break

                case (is NSError):
                    let error = x as! NSError
                    let properties: [String: Any] = [ "domain": error.domain, "code": error.code, "localizedDescription": error.localizedDescription, "userInfo": error.userInfo ]
                    jsonString = prettyPrint(properties)
                    break

                case (is NSObject):
                    let dictionary = NSObject.reflect(object: x)
                    if !dictionary.isEmpty {
                        jsonString = prettyPrint(dictionary)
                    }
                    break

                default:
                    break
            }
        }

        let message = "[\(type)] \(jsonString ?? addDash(item ?? "nil"))"
        let result = Configuration.formatter.format(level: .pretty, item: message, file: file, line: line, function: function)
        printToDebugger(result)
    }


    private static func prettyPrint(_ object: Any) -> String? {

        do {
            if JSONSerialization.isValidJSONObject(object) {
                let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                    return "\n" + string
                }
            }
            throw NSError(domain: "unable to parse json object", code: 400, userInfo: nil)
        } catch {
            return nil
        }
    }


    private static func addDash(_ x: Any) -> String {

        let string = "\(x)"
        return "- " + (string.isEmpty ? "\"\"" : string)
    }

}


// MARK: - Rosewood Benchmark

public typealias BenchmarkBlock = () -> ()

private var depth = 0

private var logs = [ String ]()

private var timingStack = [ (startTime: Double, name: String, reported: Bool) ]()

private var now: Double {
    return Date().timeIntervalSinceReferenceDate
}

private var depthIndent: String {
    return String(repeating: "\t", count: depth)
}


extension Rosewood {

    // MARK: Public Methods

    /// Calls a set of code the specified number of times, returning the average in the form of a dictionary.
    ///
    /// - Parameters:
    ///   - name: The benchmark name.
    ///   - iterations: The number of times to run code
    ///   - block: The code to run
    /// - Returns: Returns a dictionary with the time for each run.
    @discardableResult public static func benchmark(_ name: String, iterations: Int = 1, block: BenchmarkBlock) -> [String: Double] {

        guard Configuration.enabled else {
            return [:]
        }

        precondition(iterations > 0, "Iterations must be a positive integer")

        var data: [String: Double] = [:]

        var total: Double = 0
        var samples = [ Double ]()

        printToDebugger("\n🖤Measure \(name)")

        if iterations == 1 {
            let took = benchmark(name, forBlock: block).first!

            samples.append(took.value)
            total += took.value

            data["1"] = took.value
        } else {
            for i in 0..<iterations {
                let took = benchmark("Iteration \(i + 1)", forBlock: block).first!

                samples.append(took.value)
                total += took.value

                data["\(i + 1)"] = took.value
            }

            let average = total / Double(iterations)
            var deviation = 0.0
            for result in samples {

                let difference = result - average
                deviation += difference * difference
            }

            let variance = deviation / Double(iterations)

            printToDebugger("🖤\t- Total: \(total.asMilliSeconds)")
            printToDebugger("🖤\t- Average: \(average.asMilliSeconds)")
            printToDebugger("🖤\t- STD Dev: \(variance.asMilliSeconds)")

        }

        return data
    }


    /// Prints a message with an optional timestamp from start of measurement.
    ///
    /// - Parameters:
    ///   - message: The message to log.
    ///   - includeTimeStamp: Bool value to show time.
    public static func benchmarkLog(message: String, includeTimeStamp: Bool = false) {

        reportContaining()

        if includeTimeStamp {
            let currentTime = now
            let timeStamp = currentTime - timingStack[timingStack.count - 1].startTime

            printToDebugger("🖤\(depthIndent)\(message)  \(timeStamp.asMilliSeconds)")
        } else {
            printToDebugger("🖤\(depthIndent)\(message)")
        }
    }


    // MARK: Private Methods

    private static func benchmark(_ name: String, forBlock block: BenchmarkBlock) -> [String: Double] {

        startBenchmark(name)
        block()

        return stopBenchmark()
    }


    private static func startBenchmark(_ name: String) {

        reportContaining()
        timingStack.append((now, name, false))
        depth += 1
    }


    private static func stopBenchmark() -> [String: Double] {

        let endTime = now
        precondition(depth > 0, "Attempt to stop a measurement when none has been started")

        let beginning = timingStack.removeLast()
        depth -= 1

        let took = endTime - beginning.startTime

        let log = "🖤\(depthIndent)\(beginning.name): \(took.asMilliSeconds)"
        printToDebugger(log)

        return [ log: took ]
    }


    private static func reportContaining() {

        if depth > 0 && Configuration.enabled && .debug >= Configuration.minLevel {
            for stackPointer in 0..<timingStack.count {
                let containingMeasurement = timingStack[stackPointer]

                if !containingMeasurement.reported {
                    //print(String(repeating: "\t" + "Measuring \(containingMeasurement.name):", count: stackPointer))
                    timingStack[stackPointer] = (containingMeasurement.startTime, containingMeasurement.name, true)
                }
            }
        }
    }

}
