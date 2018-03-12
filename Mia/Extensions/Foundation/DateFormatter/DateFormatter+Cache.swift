import Foundation

// TODO: Replace with `localThreadSingleton`
extension DateFormatter {

    static var cachedDateFormatters = [ String: DateFormatter ]()

    static func cachedFormatter(_ format: String = DateFormatter.Presets.standard.stringFormat) -> DateFormatter {

        let hashKey = "\(format.hashValue)"

        if DateFormatter.cachedDateFormatters[hashKey] == nil {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = TimeZone.current
            formatter.locale = Calendar.current.locale
            formatter.isLenient = true
            DateFormatter.cachedDateFormatters[hashKey] = formatter
        }
        return DateFormatter.cachedDateFormatters[hashKey]!
    }

    static func cachedFormatter(_ dateStyle: Style, timeStyle: Style, doesRelativeDateFormatting: Bool) -> DateFormatter {

        let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)"

        if DateFormatter.cachedDateFormatters[hashKey] == nil {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
            formatter.timeZone = TimeZone.current
            formatter.locale = Calendar.current.locale
            formatter.isLenient = true
            DateFormatter.cachedDateFormatters[hashKey] = formatter
        }
        return DateFormatter.cachedDateFormatters[hashKey]!
    }
}

