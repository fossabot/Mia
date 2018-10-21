//: [Previous](@previous)

import Foundation

func localThreadSingleton<T: AnyObject>(key: String, create: () -> T) -> T {
    if let cachedObj = Thread.current.threadDictionary[key] as? T {
        return cachedObj
    } else {
        let newObject = create()
        Thread.current.threadDictionary[key] = newObject
        return newObject
    }
}

// Example
/// Get a thread-local date formatter object
func getThreadLocalRFC3339DateFormatter() -> DateFormatter {
    return localThreadSingleton(key: "io.multinerd.RFC3339DateFormatter") {
        print("This block will only be executed once")
        
        let rfc3339DateFormatter = DateFormatter()
        rfc3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        rfc3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return rfc3339DateFormatter
    }
}

let x1 = getThreadLocalRFC3339DateFormatter()
let x2 = getThreadLocalRFC3339DateFormatter()
let x3 = getThreadLocalRFC3339DateFormatter()

assert(x1 === x2 && x2 === x3, "Cacheing objects failed")
