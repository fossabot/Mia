// MARK: -

public protocol Theme { }

// MARK: -

public class ThemeKit {

    /// The singleton instance
    public static let shared = ThemeKit()

    /// The current theme. Use this to set the current theme.
    public var currentTheme: Theme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.themeDidChange, object: self)
        }
    }
}

// MARK: - Notification

public extension Notification.Name {
    static let themeDidChange = Notification.Name("ThemeKit.ThemeDidChangeNotification")
}
