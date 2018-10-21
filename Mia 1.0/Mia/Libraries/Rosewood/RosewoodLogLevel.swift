// MARK: - LogLevel
public enum LogLevel: Int {
    case verbose
    case info
    case warning
    case debug
    case error
    case pretty
    case bench
}

// MARK: - LogLevel Protocol
// MARK: CustomStringConvertible
extension LogLevel: CustomStringConvertible {

    public var description: String {
        switch self {
            case .verbose:  return "💚VERBOSE   "
            case .info:     return "💙INFO      "
            case .warning:  return "💛WARNING   "
            case .debug:    return "💜DEBUG     "
            case .error:    return "❤️️ERROR     "
            case .pretty:   return "💖PRETTIFY  "
            case .bench:    return "🖤BENCHMARK "
        }
    }
}

// MARK: Comparable
extension LogLevel: Comparable {

    public static func ==(x: LogLevel, y: LogLevel) -> Bool {

        return x.hashValue == y.hashValue
    }

    public static func <(x: LogLevel, y: LogLevel) -> Bool {

        return x.hashValue < y.hashValue
    }
}
