/**
 *  Time conversions used across DateTools
 */
public class Constants {

    public static let DateRFC822DateFormat1 = "EEE, dd MMM yyyy HH:mm:ss z"
    public static let DateISO8601DateFormat1 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    public static let DateISO8601DateFormat2 = "yyyyMMdd'T'HHmmss'Z'"
    public static let DateISO8601DateFormat3 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    public static let DateShortDateFormat1 = "yyyyMMdd"
    public static let DateShortDateFormat2 = "yyyy-MM-dd"
    public static let DateLongDateFormat1 = "M/d/yyyy hh:mm:ss a"

    public static let SecondsInYear: TimeInterval = 31536000
    public static let SecondsInLeapYear: TimeInterval = 31622400
    public static let SecondsInMonth28: TimeInterval = 2419200
    public static let SecondsInMonth29: TimeInterval = 2505600
    public static let SecondsInMonth30: TimeInterval = 2592000
    public static let SecondsInMonth31: TimeInterval = 2678400
    public static let SecondsInWeek: TimeInterval = 604800
    public static let SecondsInDay: TimeInterval = 86400
    public static let SecondsInHour: TimeInterval = 3600
    public static let SecondsInMinute: TimeInterval = 60
    public static let MillisecondsInDay: TimeInterval = 86400000

    public static let AllCalendarUnitFlags: Set<Calendar.Component> = [ .year, .quarter, .month, .weekOfYear, .weekOfMonth, .day, .hour, .minute, .second, .era, .weekday, .weekdayOrdinal, .weekOfYear ]
}


// MARK: - Enums

/**
 *  There may come a need, say when you are making a scheduling app, when 
 *  it might be good to know how two time periods relate to one another. 
 *  Are they the same? Is one inside of another? All these questions may be 
 *  asked using the relationship methods of DTTimePeriod.
 *
 *  Further reading: [GitHub](https://github.com/MatthewYork/DateTools#relationships), 
 *  [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
 */
public enum Relation {
    case after
    case startTouching
    case startInside
    case insideStartTouching
    case enclosingStartTouching
    case enclosing
    case enclosingEndTouching
    case exactMatch
    case inside
    case insideEndTouching
    case endInside
    case endTouching
    case before
    case none // One or more of the dates does not exist
}


/**
 *  Whether the time period is Open or Closed
 *
 *  Closed: The boundary moment of time is included in calculations.
 *
 *  Open: The boundary moment of time represents a boundary value which is excluded in regard to calculations.
 */
public enum Interval {
    case open
    case closed
}


/**
 *  When a time periods is lengthened or shortened, it does so anchoring one date
 *  of the time period and then changing the other one. There is also an option to 
 *  anchor the centerpoint of the time period, changing both the start and end dates.
 */
public enum Anchor {
    case beginning
    case center
    case end
}


/**
 *  When a time periods is lengthened or shortened, it does so anchoring one date 
 *  of the time period and then changing the other one. There is also an option to 
 *  anchor the centerpoint of the time period, changing both the start and end dates.
 */
public enum Component {
    case year
    case month
    case day
    case hour
    case minute
    case second
}


/**
 *  Time units that include weeks, but not months since their exact size is dependent
 *  on the date. Used for TimeChunk conversions.
 */
public enum TimeUnits {
    case years
    case weeks
    case days
    case hours
    case minutes
    case seconds
}
