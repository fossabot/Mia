
import Foundation

extension Date {
    
    public func timeAgo() -> String {
        
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let isPast = now - time > 0
        
        let sec: Double = abs(now - time)
        let min: Double = round(sec / 60)
        let hr: Double = round(min / 60)
        let d: Double = round(hr / 24)
        
        if sec < 60 {
            if sec < 10 {
                return isPast ? "just now" : "in a few seconds"
            } else {
                let string = isPast ? "%.f seconds ago" : "in %.f seconds"
                return String(format: string, sec)
            }
        }
        if min < 60 {
            if min == 1 {
                return isPast ? "1 minute ago" : "in 1 minute"
            } else {
                let string = isPast ? "%.f minutes ago" : "in %.f minutes"
                return String(format: string, min)
            }
        }
        if hr < 24 {
            if hr == 1 {
                return isPast ? "last hour" : "next hour"
            } else {
                let string = isPast ? "%.f hours ago" : "in %.f hours"
                return String(format: string, hr)
            }
        }
        if d < 7 {
            if d == 1 {
                return isPast ? "yesterday" : "tomorrow"
            } else {
                let string = isPast ? "%.f days ago" : "in %.f days"
                return String(format: string, d)
            }
        }
        if d < 28 {
            if isPast {
                if compare(.isLastWeek) {
                    return "last week"
                } else {
                    let string = "%.f weeks ago"
                    return String(format: string, Double(abs(since(Date(), in: .week))))
                }
            } else {
                if compare(.isNextWeek) {
                    return "next week"
                } else {
                    let string = "in %.f weeks"
                    return String(format: string, Double(abs(since(Date(), in: .week))))
                }
            }
        }
        if compare(.isThisYear) {
            if isPast {
                if compare(.isLastMonth) {
                    return "last month"
                } else {
                    let string = "%.f months ago"
                    return String(format: string, Double(abs(since(Date(), in: .month))))
                }
            } else {
                if compare(.isNextMonth) {
                    return "next month"
                } else {
                    let string = "in %.f months"
                    return String(format: string, Double(abs(since(Date(), in: .month))))
                }
            }
        }
        if isPast {
            if compare(.isLastYear) {
                return "last year"
            } else {
                let string = "%.f years ago"
                return String(format: string, Double(abs(since(Date(), in: .year))))
            }
        } else {
            if compare(.isNextYear) {
                return "next year"
            } else {
                let string = "in %.f years"
                return String(format: string, Double(abs(since(Date(), in: .year))))
            }
        }
    }
    
}
