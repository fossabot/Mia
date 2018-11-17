

// MARK: - *** Device Type ***
public enum DeviceType: String {

    case unknown
    case simulator
    case iPhone
    case iPad
    case iPod

    /// Create and returns a DeviceType for the current device.
    public init() {

        let identifier: String = Device.modelIdentifier
        if [ "i386", "x86_64" ].contains(identifier) {
            self = .simulator
        } else if identifier.contains("iPhone") {
            self = .iPhone
        } else if identifier.contains("iPad") {
            self = .iPad
        } else if identifier.contains("iPod") {
            self = .iPod
        } else {
            self = .unknown
        }
    }
}

// MARK: - *** Screen Size ***
public enum ScreenSize2: CGFloat, CustomStringConvertible {

    case unknown = 0
    case screen3dot5 = 3.5
    case screen4dot0 = 4.0
    case screen4dot7 = 4.7
    case screen5dot5 = 5.5
    case screen5dot8 = 5.8
    case screen7dot9 = 7.9
    case screen9dot7 = 9.7
    case screen10dot5 = 10.5
    case screen12dot9 = 12.9

    /// Create and returns a ScreenSize for the current device.
    public init() {

        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(Double(UIScreen.main.bounds.width), Double(UIScreen.main.bounds.height))

        func iPad1024() -> ScreenSize {

            switch Device.model {
                case .iPadMini2, .simulator(.iPadMini2), .iPadMini3, .simulator(.iPadMini3), .iPadMini4, .simulator(.iPadMini4): return .screen7dot9
                case .iPadPro10Inch, .simulator(.iPadPro10Inch): return .screen10dot5
                default: return .screen9dot7
            }
        }

        switch screenHeight {
            case 480: self = .screen3dot5
            case 568: self = .screen4dot0
            case 667: self = UIScreen.main.scale == 3.0 ? .screen5dot5 : .screen4dot7
            case 736: self = .screen5dot5
            case 812: self = .screen5dot8
            case 1024: self = iPad1024()
            case 1112: self = .screen10dot5
            case 1366: self = .screen12dot9
            default: self = .unknown
        }
    }

    public var description: String {
        switch self {
            case .screen3dot5: return "3.5 inches"
            case .screen4dot0: return "4.0 inches"
            case .screen4dot7: return "4.7 inches"
            case .screen5dot5: return "5.5 inches"
            case .screen5dot8: return "5.8 inches"
            case .screen7dot9: return "7.9 inches"
            case .screen9dot7: return "9.7 inches"
            case .screen10dot5: return "10.5 inches"
            case .screen12dot9: return "12.9 inches"
            case .unknown: return "unknown"
        }
    }
}

// MARK: - *** Screen Family ***
public enum ScreenFamily: String {

    case unknown
    case old
    case small
    case medium
    case large

    /// Create and returns a ScreenFamily for the current device.
    public init() {

        let size: ScreenSize = Device.Screen.size
        switch size {
            case .screen3dot5, .screen4dot0: self = .old
            case .screen4dot7: self = .small
            case .screen5dot5, .screen5dot8, .screen7dot9: self = .medium
            case .screen9dot7, .screen10dot5, .screen12dot9: self = .large
            default: self = .unknown
        }
    }
}

// MARK: - *** Screen Scale ***
public enum ScreenScale: CGFloat {

    case unknown = 0.0
    case x1 = 1.0
    case x2 = 2.0
    case x3 = 3.0

    /// Create and returns a ScreenScale for the current device.
    public init() {

        let scale = UIScreen.main.scale
        switch scale {
            case 1.0: self = .x1
            case 2.0: self = .x2
            case 3.0: self = .x3
            default: self = .unknown
        }
    }
}

/////

// MARK: - Protocol Extensions

extension DeviceModel: Equatable {

    public static func ==(lhs: DeviceModel, rhs: DeviceModel) -> Bool {

        return lhs.description == rhs.description
    }
}

// MARK: -


extension ScreenSize: Comparable {

    public static func <(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }
}

extension ScreenSize: Equatable {

    public static func ==(lhs: ScreenSize, rhs: ScreenSize) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}

// MARK: -

extension ScreenScale: Comparable {

    public static func <(lhs: ScreenScale, rhs: ScreenScale) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }
}

extension ScreenScale: Equatable {

    public static func ==(lhs: ScreenScale, rhs: ScreenScale) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}
