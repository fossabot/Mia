// MARK: - LogLevel

/// Enum representation of the different log levels
public enum LogLevel {
    case verbose
    case info
    case warning
    case debug
    case error
    case pretty
    case measure

    var description: String {
        switch self {
            case .verbose:  return "💚VERBOSE "
            case .info:     return "💙INFO    "
            case .warning:  return "💛WARNING "
            case .debug:    return "💜DEBUG   "
            case .error:    return "❤️️ERROR   "
            case .pretty:   return "💖PRETTIFY"
            case .measure:  return "🖤MEASURE "

        }
    }

}


// MARK: - Private Extensions
extension LogLevel: Comparable {

    public static func ==(x: LogLevel, y: LogLevel) -> Bool {

        return x.hashValue == y.hashValue
    }

    public static func <(x: LogLevel, y: LogLevel) -> Bool {

        return x.hashValue < y.hashValue
    }

}
