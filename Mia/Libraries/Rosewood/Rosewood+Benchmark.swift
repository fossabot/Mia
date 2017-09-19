public typealias BenchmarkBlock = () -> ()

extension Rosewood.Benchmark {

    // MARK: Public Methods

    /// Calls a set of code the specified number of times, returning the average in the form of a dictionary.
    ///
    /// - Parameters:
    ///   - name: The benchmark name.
    ///   - iterations: The number of times to run code
    ///   - block: The code to run
    /// - Returns: Returns a dictionary with the time for each run.
    @discardableResult
    public static func task(_ name: String, iterations: Int = 1, block: BenchmarkBlock) -> [String: Double] {

        guard Rosewood.Configuration.enabled else {
            return [:]
        }

        precondition(iterations > 0, "Iterations must be a positive integer")

        var data: [String: Double] = [:]

        var total: Double = 0
        var samples = [ Double ]()

        Rosewood.printToDebugger("\n🖤Measure \(name)")

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

            Rosewood.printToDebugger("🖤\t- Total: \(total.millisecondString)")
            Rosewood.printToDebugger("🖤\t- Average: \(average.millisecondString)")
            Rosewood.printToDebugger("🖤\t- STD Dev: \(variance.millisecondString)")

        }

        return data
    }

    /// Prints a message with an optional timestamp from start of measurement.
    ///
    /// - Parameters:
    ///   - message: The message to log.
    ///   - includeTimeStamp: Bool value to show time.
    public static func log(message: String, includeTimeStamp: Bool = false) {

        reportContaining()

        if includeTimeStamp {
            let currentTime = now
            let timeStamp = currentTime - timingStack[timingStack.count - 1].startTime

            Rosewood.printToDebugger("🖤\(depthIndent)\(message)  \(timeStamp.millisecondString)")
        } else {
            Rosewood.printToDebugger("🖤\(depthIndent)\(message)")
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

        let log = "🖤\(depthIndent)\(beginning.name): \(took.millisecondString)"
        Rosewood.printToDebugger(log)

        return [ log: took ]
    }

    private static func reportContaining() {

        if depth > 0 && Rosewood.Configuration.enabled {
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

private var depth = 0

private var logs = [ String ]()

private var timingStack = [ (startTime: Double, name: String, reported: Bool) ]()

private var now: Double {
    return Date().timeIntervalSinceReferenceDate
}

private var depthIndent: String {
    return String(repeating: "\t", count: depth)
}
