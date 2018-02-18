import Foundation


let now = Date()
let myDob = Date(year: 1991, month: 08, day: 15)!

// Compare

myDob.isEarlier(than: now)
myDob.isEarlierThanOrEqualTo(now)

now.isLater(than: myDob)
now.isLaterThanOrEqualTo(myDob)


now.isSameDay(as: now)
now.subtracting(days: 1).isYesterday

myDob.years(from: now)
myDob.months(from: now)
myDob.days(from: now)
myDob.hours(from: now)
myDob.minutes(from: now)
myDob.seconds(from: now)

let nextyear = Date().adding(years: 2).adding(days: 1)
nextyear.yearsUntil
nextyear.yearsAgo


let lastyear = Date().subtracting(years: 2)
lastyear.yearsUntil
lastyear.yearsAgo


now.month
now.year
now.hour
