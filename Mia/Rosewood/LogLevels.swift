// MARK: - LogLevel

public enum LogLevel {
    case pretty
    case measure
    case verbose
    case info
    case warning
    case debug
    case error
    
    var description: String {
        switch self {
        case .pretty:   return "💖Prettify".uppercased()
        case .measure:  return "🖤Measure ".uppercased()
        case .verbose:  return "💚Verbose ".uppercased()
        case .info:     return "💙Info    ".uppercased()
        case .warning:  return "💛Warning ".uppercased()
        case .debug:    return "💜Debug   ".uppercased()
        case .error:    return "❤️️Error   ".uppercased()
        
        }
    }
    
}


// MARK: - Private Extensions

extension LogLevel: Comparable {
    
    static public func ==(x: LogLevel, y: LogLevel) -> Bool {
        
        return x.hashValue == y.hashValue
    }
    
    
    static public func <(x: LogLevel, y: LogLevel) -> Bool {
        
        return x.hashValue < y.hashValue
    }
    
}
