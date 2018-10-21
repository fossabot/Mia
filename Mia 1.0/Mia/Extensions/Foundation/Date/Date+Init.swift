import Foundation

extension Date {

    // MARK: *** Init / Deinit ***

    /// Initialize a new `Date` instance using date and time values on a specific calendar.
    ///
    /// - Parameters:
    ///   - year: The value for year.
    ///   - month: The value for month.
    ///   - day: The value for day.
    ///   - hour: The value for hour.
    ///   - minute: The value for minute.
    ///   - second: The value for second.
    ///   - nanosecond: The value for nanosecond.
    ///   - nanosecond: The calendar to use. Defaults to `Calendar.current.`.
    public init?(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0, calendar: Calendar = Calendar.current) {

        let now = Date()
        var dateComponents = calendar.dateComponents([ .era, .year, .month, .day, .hour, .minute, .second, .nanosecond ], from: now)
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        dateComponents.nanosecond = nanosecond

        guard let date = calendar.date(from: dateComponents) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }

    /// Initialize a new `Date` instance using date values.
    ///
    /// - Parameters:
    ///   - year: The value for year.
    ///   - month: The value for month.
    ///   - day: The value for day.
    public init?(year: Int, month: Int, day: Int) {

        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }

    /// Initialize a new `Date` instance from a string.
    ///
    /// - Parameters:
    ///   - string: The date string.
    ///   - format: The date format.
    public init?(fromString string: String, format: DateFormatter.Presets) {

        switch format {
            case .dotNet: self.init(dateTime: string)
            default: self.init(string: string, format: format.stringFormat)
        }
    }

    // MARK: *** Private / Helper Methods ***

    private init?(dateTime string: String) {

        let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
            return nil
        }

        let dateString = (string as NSString).substring(with: match.range(at: 1))
        let interval = Double(dateString)! / 1000.0

        self.init(timeIntervalSince1970: interval)
    }

    private init?(string: String, format: String) {

        let formatter = DateFormatter.cachedFormatter(format)
        guard let date = formatter.date(from: string) else {
            return nil
        }

        self.init(timeInterval: 0, since: date)
    }
}


