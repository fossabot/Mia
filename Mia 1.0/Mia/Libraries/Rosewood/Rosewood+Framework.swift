// MARK: -
extension Rosewood {
    public struct Framework {
    }
}

// MARK: -
extension Rosewood.Framework {

    /// Prints debug messages to the console if debugEnabled is set to true.
    ///
    /// - Parameter message: The status to print to the console.
    static func print(framework: String, message: String, debugEnabled: Bool = true) {

        if Rosewood.Configuration.enableFramework && debugEnabled {
            Rosewood.printToDebugger("[\(framework)]: \(message)")
        }
    }
}
