public protocol EnumCollection: Hashable {
}

public extension EnumCollection {
    
    /// Sequence of all cases
    public static var allCases: AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) {
                    $0.withMemoryRebound(to: S.self, capacity: 1) {
                        $0.pointee
                    }
                }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    /// Array of all cases
    public static var allValuesAsArray: [Self] {
        return Self.allCases.map { $0 }
    }
    
    public static var allValuesAsSet: Set<Self> {
        return Set(Self.allCases.map { $0 })
    }
}

public extension EnumCollection where Self: RawRepresentable {
    
    public static var allRaws: [Self.RawValue] {
        return Self.allValuesAsArray.map { $0.rawValue }
    }
}



//func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
//    var i = 0
//    return AnyIterator {
//        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
//        if next.hashValue != i { return nil }
//        i += 1
//        return next
//    }
//}



