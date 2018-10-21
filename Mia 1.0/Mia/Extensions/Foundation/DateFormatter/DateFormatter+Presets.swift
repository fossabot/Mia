import Foundation

extension DateFormatter {

    public enum Presets {

        case date, time, dateTime
        case standard
        case isoDate, isoDateTime, isoDateTimeSec, isoDateTimeMilliSec
        case dotNet, dotNetString
        case httpHeader
        case rss(alt: Bool)
        case custom(String)

        var stringFormat: String {
            switch self {
                case .date: return "EEEE MMMM dd yyyy"
                case .time: return "hh:mm:ss a z"
                case .dateTime: return "EEEE MMMM dd yyyy hh:mm:ss a z"
                case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
                case .isoDate: return "yyyy-MM-dd"
                case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
                case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
                case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                case .dotNet: return "/Date(%d%.f)/"
                case .dotNetString: return "M/d/yyyy hh:mm:ss a"
                case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
                case .rss(let isAlt): return isAlt ? "d MMM yyyy HH:mm:ss ZZZ" : "EEE, d MMM yyyy HH:mm:ss ZZZ"
                case .custom(let format): return format
            }
        }
    }
}

