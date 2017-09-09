public enum ScreenSize: Int {

    case unknown = 0
    case _3_5inch
    case _4inch
    case _4_7inch
    case _5_5inch
    case _7_9inch
    case _9_7inch
    case _10_5inch
    case _12_9inch

    public var description: String {
        switch self {
            case ._3_5inch: return "3.5 Inches"
            case ._4inch:   return "4.0 Inches"
            case ._4_7inch: return "4.7 Inches"
            case ._5_5inch: return "5.5 Inches"
            case ._7_9inch: return "7.9 Inches"
            case ._9_7inch: return "9.7 Inches"
            case ._10_5inch: return "10.5 Inches"
            case ._12_9inch: return "12.9 Inches"
            case .unknown:  return "Unknown Device Size"
        }
    }
    
    public var bounds: CGSize {
        return UIScreen.main.bounds.size
    }

}


extension ScreenSize: Comparable {

    public static func <(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }


    public static func ==(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}



public enum Sizes: CGFloat {
    case _3_5_inches = 480
    case _4_inches = 568
    case _4_7_inches = 667
    case _5_5_inches = 736
    
    var description: String {
        switch self {
        case ._3_5_inches: return "3.5 Inches"
        case ._4_inches:   return "4 Inches"
        case ._4_7_inches: return "4.7 Inches"
        case ._5_5_inches: return "5.5 Inches"
        }
    }
    
}
