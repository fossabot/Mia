import UIKit

// TODO: Print to a text file when used on a device.
// TODO: Crash Reporter

private let queue = DispatchQueue(label: "Multinerd.Rosewood")

public struct Rosewood {

    /// The logging configurations.
    public struct Configuration {

        /// The logger state.
        public static var enabled: Bool = true

        /// The minimum level of severity.
        public static var minLevel: LogLevel = .verbose

        /// The logger formatter.
        public static var formatter: RosewoodFormatter = .oneline

        /// The logger state.
        public static var isAsync: Bool = true

    }

    public struct Log { }

    public struct Benchmark { }

    public struct PrettyPrint { }

    // MARK: Private Methods

    private init() {}

    static func printToDebugger(_ message: String) {

        if Configuration.isAsync {
            queue.async {
                print(message)
            }
        } else {
            queue.sync {
                print(message)
            }
        }
    }

}

// MARK: - LogLevel Extensions
public enum LogLevel: Int {

    case verbose
    case info
    case warning
    case debug
    case error
    case pretty
    case bench
}

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

extension LogLevel: Comparable {

    public static func ==(x: LogLevel, y: LogLevel) -> Bool {

        return x.hashValue == y.hashValue
    }

    public static func <(x: LogLevel, y: LogLevel) -> Bool {

        return x.hashValue < y.hashValue
    }
}
