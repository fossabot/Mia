import Foundation

public extension Date {

    // MARK: - Formatted Date - Style

    /// Convenience method that returns a formatted string representing the receiver's date formatted to a given style, time zone and locale
    ///
    /// - Parameters:
    ///   - dateStyle: The date style to use.
    ///   - timeZone: the time zone to use.
    ///   - locale: The local to use.
    /// - Returns: A formatted string from date.
    public func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone = TimeZone.autoupdatingCurrent, locale: Locale = Locale.autoupdatingCurrent) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale

        return dateFormatter.string(from: self)
    }

    // MARK: - Formatted Date - String

    /// Convenience method that returns a formatted string representing the receiver's date formatted to a given date format, time zone and locale
    ///
    /// - Parameters:
    ///   - dateFormat: The date format to use.
    ///   - timeZone: the time zone to use.
    ///   - locale: The local to use.
    /// - Returns: A formatted string from date.
    public func format(with dateFormat: String, timeZone: TimeZone = TimeZone.autoupdatingCurrent, locale: Locale = Locale.autoupdatingCurrent) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale

        return dateFormatter.string(from: self)
    }
}

