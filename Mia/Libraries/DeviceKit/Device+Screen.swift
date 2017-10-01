// MARK: -
public extension Device.Screen {

    public enum Size: Double {

        case unknown = 0
        case screen3dot5 = 3.5
        case screen4 = 4.0
        case screen4dot7 = 4.7
        case screen5dot5 = 5.5
        case screen7dot9 = 7.9
        case screen9dot7 = 9.7
        case screen10dot5 = 10.5
        case screen12dot9 = 12.9

        fileprivate init() {

            let w: Double = Double(UIScreen.main.bounds.width)
            let h: Double = Double(UIScreen.main.bounds.height)
            let screenHeight: Double = max(w, h)

            func iPad1024() -> Size {

                switch Device.Device.model {
                case .iPadMini, .simulator(.iPadMini),
                     .iPadMini2, .simulator(.iPadMini2),
                     .iPadMini3, .simulator(.iPadMini3),
                     .iPadMini4, .simulator(.iPadMini4): return .screen7dot9
                case .iPadPro10Inch, .simulator(.iPadPro10Inch): return .screen10dot5
                default: return .screen9dot7
                }
            }

            switch screenHeight {
                case 480: self = .screen3dot5
                case 568: self = .screen4
                case 667: self = UIScreen.main.scale == 3.0 ? .screen5dot5 : .screen4dot7
                case 736: self = .screen5dot5
                case 1024: self = iPad1024()
                case 1112: self = .screen10dot5
                case 1366: self = .screen12dot9
                default: self = .unknown
            }
        }
    }

    /// Determines whether the screen is retina
    public static var isRetina: Bool {
        return UIScreen.main.scale > 1.0
    }

    /// Determines whether the screen is zoomed
    public static var isZoomed: Bool {
        if UIScreen.main.scale == 3.0 {
            return UIScreen.main.nativeScale > 2.7
        } else {
            return UIScreen.main.nativeScale > UIScreen.main.scale
        }
    }

    /// Determines whether the screen is being mirrored
    public static var isScreenMirrored: Bool {

        if UIScreen.main.mirrored != nil {
            return true
        }
        return false
    }

    /// The current brightness
    public static var brightness: CGFloat {

        return UIScreen.main.brightness
    }

    /// The current orientation
    public static var orientation: UIDeviceOrientation {

        return UIDevice.current.orientation
    }

    /// The current state of the battery
    public static var size: Size {
        return Size()
    }

    /// The screens pixel size
    public static var pixelSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        let scale = UIScreen.main.scale

        return CGSize(width: screenSize.width * scale, height: screenSize.height * scale)
    }
}

extension Device.Screen.Size: CustomStringConvertible {

    public var description: String {
        switch self {
            case .screen3dot5: return "3.5 inches"
            case .screen4:   return "4.0 inches"
            case .screen4dot7: return "4.7 inches"
            case .screen5dot5: return "5.5 inches"
            case .screen7dot9: return "7.9 inches"
            case .screen9dot7: return "9.7 inches"
            case .screen10dot5: return "10.5 inches"
            case .screen12dot9: return "12.9 inches"
            case .unknown:  return "unknown"
        }
    }
}

extension Device.Screen.Size: Comparable {

    public static func < (lhs: Device.Screen.Size, rhs: Device.Screen.Size) -> Bool {

        return lhs.rawValue < rhs.rawValue
    }
}

extension Device.Screen.Size: Equatable {

    public static func == (lhs: Device.Screen.Size, rhs: Device.Screen.Size) -> Bool {

        return lhs.rawValue == rhs.rawValue
    }
}
