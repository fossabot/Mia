extension Rosewood.Log {

    // MARK: Public Methods

    /// Logs a message with a verbose severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func verbose(_ items: Any..., file: String = #file, line: Int = #line, function: String = #function) {

        log(.verbose, items, file, line, function)
    }

    /// Logs a message with a debug severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func debug(_ items: Any..., file: String = #file, line: Int = #line, function: String = #function) {

        log(.debug, items, file, line, function)
    }

    /// Logs a message with a info severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func info(_ items: Any..., file: String = #file, line: Int = #line, function: String = #function) {

        log(.info, items, file, line, function)
    }

    /// Logs a message with a warning severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func warning(_ items: Any..., file: String = #file, line: Int = #line, function: String = #function) {

        log(.warning, items, file, line, function)
    }

    /// Logs a message with a error severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public static func error(_ items: Any..., file: String = #file, line: Int = #line, function: String = #function) {

        log(.error, items, file, line, function)
    }

    // MARK: Private Methods

    private static func log(_ level: LogLevel, _ items: [Any], _ file: String, _ line: Int, _ function: String) {

        guard Rosewood.Configuration.enabled && level >= Rosewood.Configuration.minLevel else {
            return
        }

        let log = Rosewood.Configuration.formatter.logFormat(level: level, items: items, file: file, line: line, function: function)
        Rosewood.printToDebugger(log)
    }

}
