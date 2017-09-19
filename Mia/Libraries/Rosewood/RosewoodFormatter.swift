// MARK: -
public struct RosewoodFormatter {

    public enum Component {

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

    // MARK: Variables

    var format: String
    var components: [Component]

    // MARK: Init/Deinit

    /// Creates and returns a new formatter with the specified format and components.
    ///
    /// - Parameters:
    ///   - format: The formatter format.
    ///   - components: The formatter components.
    public init(_ format: String, _ components: [Component]) {

        self.format = format
        self.components = components
    }

    // MARK: Private Methods

    func logFormat(level: LogLevel, items: [Any], file: String, line: Int, function: String) -> String {

        let arguments = components.map { (component: Component) -> CVarArg in
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
                    return items.map({ String(describing: $0) }).joined(separator: " ")

                case .block(let block):
                    return block().flatMap({ String(describing: $0) }) ?? ""

            }
        }

        return String(format: format, arguments: arguments)
    }

    func prettyFormat(level: LogLevel, item: String, file: String, line: Int, function: String) -> String {

        let arguments = components.map { (component: Component) -> CVarArg in
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

    // MARK: Helpers Methods

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

// MARK: - Presets
extension RosewoodFormatter {

    /// Default formatter provided for your convenience
    public static let `default` = RosewoodFormatter(
            "\n%@ %@ " + "\n Source: %@:%@:%@" + "\nMessage: %@",
            [ .level, .date("yyyy-MM-dd HH:mm:ss.SSS"), .file(fullPath: false, fileExtension: false), .function, .line, .message ]
    )

    /// Oneline formatter provided for your convenience
    public static let oneline = RosewoodFormatter(
            "➡%@%@ %@.%@:%@ %@",
            [ .level, .date("HH:mm:ss.SSS"), .file(fullPath: false, fileExtension: false), .function, .line, .message ]
    )

    /// Detailed formatter provided for your convenience
    public static let detailed = RosewoodFormatter(
            "\n%@ %@ " + "\n Source: " + "\n\t| File: %@" + "\n\t| Func: %@" + "\n\t| Line: %@" + "\n Message: %@",
            [ .level, .date("yyyy-MM-dd HH:mm:ss.SSS"), .file(fullPath: false, fileExtension: true), .function, .line, .message ]
    )

}

extension RosewoodFormatter: CustomStringConvertible {

    public var description: String {
        return String(format: format, arguments: components.map { (component: Component) -> CVarArg in
            return String(describing: component).uppercased()
        })
    }

}
