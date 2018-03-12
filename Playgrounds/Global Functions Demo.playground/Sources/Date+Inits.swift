import Foundation

public extension Date {
    
    // MARK: - Initializers
    
    /// Init date with components.
    ///
    /// - Parameters:
    ///   - year: Year component of new date
    ///   - month: Month component of new date
    ///   - day: Day component of new date
    ///   - hour: Hour component of new date
    ///   - minute: Minute component of new date
    ///   - second: Second component of new date
    public init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        self = date
    }
    
    /// Init date from string, given a format string, according to Apple's date formatting guide, and time zone.
    ///
    /// - Parameters:
    ///   - dateString: Date in the formatting given by the format parameter
    ///   - format: Format style using Apple's date formatting guide
    ///   - timeZone: Time zone of date
    public init?(dateString: String, format: String, timeZone: TimeZone = TimeZone.autoupdatingCurrent) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none;
        dateFormatter.timeStyle = .none;
        dateFormatter.timeZone = timeZone;
        dateFormatter.dateFormat = format;
        
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        self = date
    }
    
    /// Init Date from a C# DateTime string such as `Date(1440156888750-0700)`.
    /// Returns nil if `dateTimeString` is not valid.
    ///
    /// - Parameter dateTimeString: The string value to parse.
    public init?(dateTimeString: String) {
        
        let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: dateTimeString, range: NSRange(location: 0, length: dateTimeString.utf16.count)) else {
            print("Failed to find a match for datetime: \(dateTimeString)")
            return nil
        }
        
        let dateString = (dateTimeString as NSString).substring(with: match.range(at: 1))     // Extract milliseconds
        let timeStamp = Double(dateString)! / 1000.0 // Convert to UNIX timestamp in seconds
        
        self.init(timeIntervalSince1970: timeStamp) // Create Date from timestamp
    }
}
