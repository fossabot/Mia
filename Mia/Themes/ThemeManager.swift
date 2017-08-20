import Foundation


public class ThemeManager {

    /// The singleton instance
    public static let shared = ThemeManager()

    /// The current theme. Use this to set the current theme.
    public var currentTheme: Theme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.themeDidChange, object: self)
        }
    }
}
