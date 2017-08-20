import Foundation


public extension Date {

    /// Init date with components.
    ///
    /// - Parameters:
    ///   - year: Year component of new date
    ///   - month: Month component of new date
    ///   - day: Day component of new date
    ///   - hour: Hour component of new date
    ///   - minute: Minute component of new date
    ///   - second: Second component of new date
    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second

        guard let date = Calendar.current.date(from: dateComponents) else {
            self = Date()
            return
        }
        self = date
    }

    /// Init date with components. Hour, minutes, and seconds set to zero.
    ///
    /// - Parameters:
    ///   - year: Year component of new date
    ///   - month: Month component of new date
    ///   - day: Day component of new date
    public init(year: Int, month: Int, day: Int) {

        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }

    /// Init Date from an array of known date formats. 
    /// Returns nil if `dateString` is not valid or date format is not in DateFormats.array.
    ///
    /// - Parameter dateString: THe string value to parse.
    public init?(dateString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none;
        dateFormatter.timeStyle = .none;
        dateFormatter.timeZone = TimeZone.current;

        for format: String in DateFormats.array {

            dateFormatter.dateFormat = format;

            guard let parsedDate = dateFormatter.date(from: dateString) else {
                continue
            }
            self = parsedDate
        }
        return nil
    }

    /// Init Date from a C# DateTime string such as `Date(1440156888750-0700)`.
    /// Returns nil if `dateTimeString` is not valid.
    ///
    /// - Parameter dateTimeString: The string value to parse.
    public init?(dateTimeString: String) {

        let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: dateTimeString, range: NSRange(location: 0, length: dateTimeString.utf16.count)) else {
            Rosewood.info("Failed to find a match")
            return nil
        }

        let dateString = (dateTimeString as NSString).substring(with: match.rangeAt(1))     // Extract milliseconds
        let timeStamp = Double(dateString)! / 1000.0 // Convert to UNIX timestamp in seconds

        self.init(timeIntervalSince1970: timeStamp) // Create Date from timestamp
    }

}
