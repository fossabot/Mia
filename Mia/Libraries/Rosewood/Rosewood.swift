// MARK: -
public struct Rosewood {

    // MARK: Configurations

    /// The logging configurations.
    public struct Configuration {

        /// The logger state.
        public static var enabled: Bool = true

        /// The minimum level of severity.
        public static var minLevel: LogLevel = .verbose

        /// The logger formatter.
        public static var formatter: RosewoodFormatter = .oneLine

        /// The logger state.
        public static var isAsync: Bool = true

        /// The logger state for Mia Framework.
        public static var enableFramework: Bool = true
    }

    private static let queue = DispatchQueue(label: "Multinerd.Rosewood")

    // MARK: Private Methods

    private init() {}

    static func printToDebugger(_ message: String) {

        if Configuration.isAsync {
            queue.async { print(message) }
        } else {
            queue.sync { print(message) }
        }
    }
}
