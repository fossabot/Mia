import Foundation

public extension Date {

    // MARK: *** Public Methods ***

    /// Get a string representation using a preset/custom format.
    ///
    /// - Parameter format: The format to use.
    /// - Returns: A `String` representation using a given format.
    public func format(to format: DateFormatter.Presets = .standard) -> String {

        switch format {
            case .dotNet: return String(format: format.stringFormat, 1000 * self.timeIntervalSince1970, 0)
            default: return DateFormatter.cachedFormatter(format.stringFormat).string(from: self)
        }
    }

    /// Get a string representation using DateFormatter.Style.
    ///
    /// - Parameters:
    ///   - dateStyle: The date style to use.
    ///   - timeStyle: The time style to use. Defaults to `.none`.
    /// - Returns: Returns: A `String` representation using a given `DateFormatter.Style`.
    public func format(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style = .none, isRelative: Bool = false) -> String {

        let formatter = DateFormatter.cachedFormatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: isRelative)
        return formatter.string(from: self)
    }
}


