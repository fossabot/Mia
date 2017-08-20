import Foundation
import UIKit


public enum DateFormats {
    case sql

    case rfc822
    case iso8601Format1
    case iso8601Format2
    case iso8601Format3
    case shortWithDash
    case short

    var description: String {
        switch self {
            case .sql:  return "M/d/yyyy hh:mm:ss a"
            case .rfc822:     return "EEE, dd MMM yyyy HH:mm:ss z"
            case .iso8601Format1:  return "yyyy-MM-dd'T'HH:mm:ss'Z'"
            case .iso8601Format2:    return "yyyyMMdd'T'HHmmss'Z'"
            case .iso8601Format3:    return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            case .shortWithDash:   return "yyyy-MM-dd"
            case .short:  return "yyyyMMdd"

        }
    }

    public static var array: [String] {
        return [ DateFormats.sql.description,
                 DateFormats.rfc822.description,
                 DateFormats.iso8601Format1.description,
                 DateFormats.iso8601Format2.description,
                 DateFormats.iso8601Format3.description,
                 DateFormats.shortWithDash.description,
                 DateFormats.short.description
        ]
    }

}
