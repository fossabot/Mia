public enum DeviceModel {

    indirect case simulator(DeviceModel)

    case iPodTouch1G, iPodTouch2G, iPodTouch3G, iPodTouch4G, iPodTouch5G, iPodTouch6G

    case iPhone2G, iPhone3G, iPhone3GS, iPhone4, iPhone4S
    case iPhone5, iPhone5C, iPhone5S, iPhoneSE
    case iPhone6, iPhone6Plus, iPhone6S, iPhone6SPlus, iPhone7, iPhone7Plus

    case iPad1, iPad2, iPad3, iPad4, iPad5
    case iPadAir, iPadAir2
    case iPadMini, iPadMini2, iPadMini3, iPadMini4
    case iPadPro9Inch, iPadPro10Inch, iPadPro12Inch

    case unknown(String)

    
    public var description: String {

        switch self {
            case .simulator(let model): return "Simulator (\(model))"

            case .iPodTouch1G: return "iPod Touch 1"
            case .iPodTouch2G: return "iPod Touch 2"
            case .iPodTouch3G: return "iPod Touch 3"
            case .iPodTouch4G: return "iPod Touch 4"
            case .iPodTouch5G: return "iPod Touch 5"
            case .iPodTouch6G: return "iPod Touch 6"

            case .iPhone2G: return "iPhone"
            case .iPhone3G: return "iPhone 3G"
            case .iPhone3GS: return "iPhone 3GS"
            case .iPhone4: return "iPhone 4"
            case .iPhone4S: return "iPhone 4s"
            case .iPhone5: return "iPhone 5"
            case .iPhone5C: return "iPhone 5C"
            case .iPhone5S: return "iPhone 5S"
            case .iPhone6: return "iPhone 6"
            case .iPhone6Plus: return "iPhone 6+"
            case .iPhone6S: return "iPhone 6S"
            case .iPhone6SPlus: return "iPhone 6S+"
            case .iPhone7: return "iPhone 7"
            case .iPhone7Plus: return "iPhone 7+"
            case .iPhoneSE: return "iPhone 5E"

            case .iPad1: return "iPad 1"
            case .iPad2: return "iPad 2"
            case .iPad3: return "iPad 3"
            case .iPad4: return "iPad 4"
            case .iPad5: return "iPad 5"

            case .iPadMini: return "iPad Mini"
            case .iPadMini2: return "iPad Mini 2"
            case .iPadMini3: return "iPad Mini 3"
            case .iPadMini4: return "iPad Mini 4"

            case .iPadAir: return "iPad Air"
            case .iPadAir2: return "iPad Air 2"

            case .iPadPro9Inch: return "iPad Pro 9.7"
            case .iPadPro10Inch: return "iPad Pro 10.5"
            case .iPadPro12Inch: return "iPad pro 12.9"

            case .unknown(let device): return "Unknown Device Model: \(device)"
        }
    }

    public var identifiers: [String] {

        switch self {
            case .simulator(let device): return [ "Simulator \(device)" ]

            case .iPodTouch1G: return [ "iPod1,1" ]
            case .iPodTouch2G: return [ "iPod2,1" ]
            case .iPodTouch3G: return [ "iPod3,1" ]
            case .iPodTouch4G: return [ "iPod4,1" ]
            case .iPodTouch5G: return [ "iPod5,1" ]
            case .iPodTouch6G: return [ "iPod7,1" ]

            case .iPhone2G: return [ "iPhone1,1" ]
            case .iPhone3G: return [ "iPhone1,2" ]
            case .iPhone3GS: return [ "iPhone2,1" ]
            case .iPhone4: return [ "iPhone3,1", "iPhone3,2", "iPhone3,3" ]
            case .iPhone4S: return [ "iPhone4,1" ]
            case .iPhone5: return [ "iPhone5,1", "iPhone5,2" ]
            case .iPhone5C: return [ "iPhone5,3", "iPhone5,4" ]
            case .iPhone5S: return [ "iPhone6,1", "iPhone6,2" ]
            case .iPhone6: return [ "iPhone7,2" ]
            case .iPhone6Plus: return [ "iPhone7,1" ]
            case .iPhone6S: return [ "iPhone8,1" ]
            case .iPhone6SPlus: return [ "iPhone8,2" ]
            case .iPhone7: return [ "iPhone9,1", "iPhone9,3" ]
            case .iPhone7Plus: return [ "iPhone9,2", "iPhone9,4" ]
            case .iPhoneSE: return [ "iPhone8,4" ]

            case .iPad1: return [ "iPad1,1" ]
            case .iPad2: return [ "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4" ]
            case .iPad3: return [ "iPad3,1", "iPad3,2", "iPad3,3" ]
            case .iPad4: return [ "iPad3,4", "iPad3,5", "iPad3,6" ]
            case .iPad5: return [ "iPad6,11", "iPad6,12" ]

            case .iPadMini: return [ "iPad2,5", "iPad2,6", "iPad2,7" ]
            case .iPadMini2: return [ "iPad4,4", "iPad4,5", "iPad4,6" ]
            case .iPadMini3: return [ "iPad4,7", "iPad4,8", "iPad4,9" ]
            case .iPadMini4: return [ "iPad5,1", "iPad5,2" ]

            case .iPadAir: return [ "iPad4,1", "iPad4,2", "iPad4,3" ]
            case .iPadAir2: return [ "iPad5,3", "iPad5,4" ]

            case .iPadPro9Inch: return [ "iPad6,3", "iPad6,4" ]
            case .iPadPro10Inch: return [ "iPad7,3", "iPad7,4" ]
            case .iPadPro12Inch: return [ "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2" ]

            case .unknown(let device): return [ device ]
        }
    }

    public var screenSize: ScreenSize {

        switch self {
            case .simulator(let model): return model.screenSize

            case .iPodTouch1G: return ._3_5inch
            case .iPodTouch2G: return ._3_5inch
            case .iPodTouch3G: return ._3_5inch
            case .iPodTouch4G: return ._3_5inch
            case .iPodTouch5G: return ._4inch
            case .iPodTouch6G: return ._4inch

            case .iPhone2G: return ._3_5inch
            case .iPhone3G: return ._3_5inch
            case .iPhone3GS: return ._3_5inch
            case .iPhone4: return ._3_5inch
            case .iPhone4S: return ._3_5inch
            case .iPhone5: return ._4inch
            case .iPhone5C: return ._4inch
            case .iPhone5S: return ._4inch
            case .iPhone6: return ._4_7inch
            case .iPhone6Plus: return ._5_5inch
            case .iPhone6S: return ._4_7inch
            case .iPhone6SPlus: return ._5_5inch
            case .iPhone7: return ._4_7inch
            case .iPhone7Plus: return ._5_5inch
            case .iPhoneSE: return ._4inch

            case .iPad1: return ._9_7inch
            case .iPad2: return ._9_7inch
            case .iPad3: return ._9_7inch
            case .iPad4: return ._9_7inch
            case .iPad5: return ._9_7inch

            case .iPadMini: return ._7_9inch
            case .iPadMini2: return ._7_9inch
            case .iPadMini3: return ._7_9inch
            case .iPadMini4: return ._7_9inch

            case .iPadAir: return ._9_7inch
            case .iPadAir2: return ._9_7inch

            case .iPadPro9Inch: return ._9_7inch
            case .iPadPro10Inch: return ._10_5inch
            case .iPadPro12Inch: return ._12_9inch

            case .unknown(_): return .unknown
        }
    }

    public var aspectRatio: AspectRatio {

        switch self {

            case .simulator(let model): return model.aspectRatio

            case .iPodTouch1G: return ._3x2
            case .iPodTouch2G: return ._3x2
            case .iPodTouch3G: return ._3x2
            case .iPodTouch4G: return ._3x2
            case .iPodTouch5G: return ._16x9
            case .iPodTouch6G: return ._16x9

            case .iPhone2G: return ._3x2
            case .iPhone3G: return ._3x2
            case .iPhone3GS: return ._3x2
            case .iPhone4: return ._3x2
            case .iPhone4S: return ._3x2
            case .iPhone5: return ._16x9
            case .iPhone5C: return ._16x9
            case .iPhone5S: return ._16x9
            case .iPhone6: return ._16x9
            case .iPhone6Plus: return ._16x9
            case .iPhone6S: return ._16x9
            case .iPhone6SPlus: return ._16x9
            case .iPhone7: return ._16x9
            case .iPhone7Plus: return ._16x9
            case .iPhoneSE: return ._16x9

            case .iPad1: return ._4x3
            case .iPad2: return ._4x3
            case .iPad3: return ._4x3
            case .iPad4: return ._4x3
            case .iPad5: return ._4x3

            case .iPadMini: return ._4x3
            case .iPadMini2: return ._4x3
            case .iPadMini3: return ._4x3
            case .iPadMini4: return ._4x3

            case .iPadAir: return ._4x3
            case .iPadAir2: return ._4x3

            case .iPadPro9Inch: return ._4x3
            case .iPadPro10Inch: return ._4x3
            case .iPadPro12Inch: return ._4x3

            case .unknown(_): return .unknown
        }
    }

}
