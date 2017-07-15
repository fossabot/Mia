internal let queue = DispatchQueue(label: "Multinerd.Rosewood")


// MARK: - Rosewood Delegate

public protocol RosewoodDelegate: NSObjectProtocol {
    func rosewoodDidLog(message: String)
}


// MARK: - Rosewood Configurations

public class Rosewood {
    
    /// The shared instance.
    public static let shared = Rosewood()
    
    /// The logging delegate.
    public static weak var delegate: RosewoodDelegate?
    
    /// The logging configurations.
    public struct Configuration {
        
        /// The logger state.
        public static var enabled: Bool = true
        
        /// The minimum level of severity.
        public static var minLevel: LogLevel = .verbose
        
        /// The logger formatter.
        public static var formatter: Formatter = .default
        
        /// The logger state.
        public static var isAsync: Bool = true
        
    }
    
    private init() { }
    
    
    func printToDebugger(_ message: String) -> Void {
        
        if Configuration.isAsync {
            queue.async {
                Swift.print(message)
                Rosewood.delegate?.rosewoodDidLog(message: message)
            }
        } else {
            queue.sync {
                Swift.print(message)
                Rosewood.delegate?.rosewoodDidLog(message: message)
            }
        }
        
    }
    
}


// MARK: - Rosewood Logging

extension Rosewood {
    
    /// Logs a message with a verbose severity level.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - separator: The separator between the items.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public func verbose(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {
        
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
    public func debug(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {
        
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
    public func info(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {
        
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
    public func warning(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {
        
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
    public func error(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line, function: String = #function) {
        
        log(.error, items, separator, file, line, function)
    }
    
    
    private func log(_ level: LogLevel, _ items: [Any], _ separator: String, _ file: String, _ line: Int, _ function: String) {
        
        guard Configuration.enabled && level >= Configuration.minLevel else {
            return
        }
        
        let result = Configuration.formatter.format(level: level, items: items, separator: separator, file: file, line: line, function: function)
        printToDebugger(result)
        
    }
    
}


// MARK: - Rosewood PrettyPrint

extension Rosewood {
    
    /// Prettyprint an item.
    ///
    /// - Parameters:
    ///   - items: The items to log.
    ///   - file: The file in which the log happens.
    ///   - line: The line at which the log happens.
    ///   - function: The function in which the log happens.
    public func prettyprint(_ items: Any?..., file: String = #file, line: Int = #line, function: String = #function) {
        
        for item in items {
            log(.pretty, item, file, line, function)
        }
    }
    
    
    private func log(_ level: LogLevel, _ item: Any?, _ file: String, _ line: Int, _ function: String) {
        
        guard Configuration.enabled else {
            return
        }
        
        var type = "nil"
        if let x = item {
            type = String(describing: Mirror(reflecting: x).subjectType)//.trimmingCharacters(in: CharacterSet.letters.inverted)
        };
        
        var jsonString: String? = nil
        if let x = item {
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
    
    
    private func prettyPrint(_ object: Any) -> String? {
        
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
    
    
    private func addDash(_ x: Any) -> String {
        
        let string = "\(x)"
        return "- " + (string.isEmpty ? "\"\"" : string)
    }
    
}
