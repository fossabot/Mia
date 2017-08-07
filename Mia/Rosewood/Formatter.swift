// MARK: - LoggingComponent
public enum LoggingComponent {
    /// The log date.
    case date(String)

    /// The log file path.
    case file(fullPath: Bool, fileExtension: Bool)

    /// The log function.
    case function

    /// The log line number.
    case line

    /// The severity level.
    case level

    /// The log message.
    case message

    /// The log block.
    case block(() -> Any?)
}


// MARK: - Formatter Configurations
public class LogFormatter {

    /// The formatter format.
    var format: String

    /// The formatter components.
    var components: [LoggingComponent]

    /// The formatter textual representation.
    var description: String {
        return String(format: format, arguments: components.map { (component: LoggingComponent) -> CVarArg in
            return String(describing: component).uppercased()
        })
    }

    /// Creates and returns a new formatter with the specified format and components.
    ///
    /// - Parameters:
    ///   - format: The formatter format.
    ///   - components: The formatter components.
    public convenience init(_ format: String, _ components: LoggingComponent...) {

        self.init(format, components)
    }

    /// Creates and returns a new formatter with the specified format and components.
    ///
    /// - Parameters:
    ///   - format: The formatter format.
    ///   - components: The formatter components.
    public init(_ format: String, _ components: [LoggingComponent]) {

        self.format = format
        self.components = components
    }

}


// MARK: - Formatter Presets
extension LogFormatter {

    /// Default formatter provided for your convenience
    public static let `default` = LogFormatter("\n%@ %@ " + "\n Source: %@:%@:%@" + "\nMessage: %@", [ .level, .date("yyyy-MM-dd HH:mm:ss.SSS"), .file(fullPath: false, fileExtension: false), .function, .line, .message ])

    /// Oneline formatter provided for your convenience
    public static let oneline = LogFormatter("➡%@%@ %@.%@:%@ %@", [ .level, .date("HH:mm:ss.SSS"), .file(fullPath: false, fileExtension: false), .function, .line, .message ])

    /// Detailed formatter provided for your convenience
    public static let detailed = LogFormatter("\n%@ %@ " + "\n Source: " + "\n\t| File: %@" + "\n\t| Func: %@" + "\n\t| Line: %@" + "\n Message: %@", [ .level, .date("yyyy-MM-dd HH:mm:ss.SSS"), .file(fullPath: false, fileExtension: true), .function, .line, .message ])

}


// MARK: - Formatter Logging Methods
extension LogFormatter {

    // For logging use
    func format(level: LogLevel, items: [Any], separator: String, file: String, line: Int, function: String) -> String {

        let arguments = components.map { (component: LoggingComponent) -> CVarArg in
            switch component {
                case .date(let dateFormat):
                    return format(date: Date(), dateFormat: dateFormat)

                case .file(let fullPath, let fileExtension):
                    return format(file: file, fullPath: fullPath, fileExtension: fileExtension)

                case .function:
                    return String(function)

                case .line:
                    return String(line)

                case .level:
                    return level.description

                case .message:
                    return items.map({ String(describing: $0) }).joined(separator: separator)

                case .block(let block):
                    return block().flatMap({ String(describing: $0) }) ?? ""

            }
        }

        return String(format: format, arguments: arguments)
    }

    // For prettyprint use
    func format(level: LogLevel, item: String, file: String, line: Int, function: String) -> String {

        let arguments = components.map { (component: LoggingComponent) -> CVarArg in
            switch component {
                case .date(let dateFormat):
                    return format(date: Date(), dateFormat: dateFormat)

                case .file(let fullPath, let fileExtension):
                    return format(file: file, fullPath: fullPath, fileExtension: fileExtension)

                case .function:
                    return String(function)

                case .line:
                    return String(line)

                case .level:
                    return level.description

                case .message:
                    return item

                case .block(let block):
                    return block().flatMap({ String(describing: $0) }) ?? ""

            }
        }

        return String(format: format, arguments: arguments)
    }

}


// MARK: - Formatter Private Methods
extension LogFormatter {

    func format(date: Date, dateFormat: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }

    func format(file: String, fullPath: Bool, fileExtension: Bool) -> String {

        var file = file

        if !fullPath {
            file = file.lastPathComponent
        }
        if !fileExtension {
            file = file.stringByDeletingPathExtension
        }

        return file
    }

}
