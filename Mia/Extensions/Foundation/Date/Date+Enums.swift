import Foundation

extension Date {

    public enum Component {
        case year, month, week, day
        case hour, minute, second
        case weekday, nthWeekday
    }

    public enum Comparators {

        case isToday, isTomorrow, isYesterday, isSameDay(as: Date)
        case isThisWeek, isNextWeek, isLastWeek, isSameWeek(as: Date)
        case isThisMonth, isNextMonth, isLastMonth, isSameMonth(as: Date)
        case isThisYear, isNextYear, isLastYear, isSameYear(as: Date)

        case equals(Date)
        case isBetween(Date, Date)

        case isLater(than: Date), isLaterOrEqual(to: Date), isInTheFuture
        case isEarlier(than: Date), isEarlierOrEqual(to: Date), isInThePast

        case isWeekday, isWeekend

        case isLeapYear
    }

    public enum WeekDay: Int {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
    }

    public enum For {

        case nextDay(WeekDay), previousDay(WeekDay)

        case nextWorkDay, previousWorkDay

        case next(Date.Component), previous(Date.Component)
        case startOf(Date.Component), endOf(Date.Component)

        case nearestMinute(minute: Int), nearestHour(hour: Int)
    }

    public enum TimeOfDay {

        case none
        case morning
        case afternoon
        case evening
        case night
    }
}
