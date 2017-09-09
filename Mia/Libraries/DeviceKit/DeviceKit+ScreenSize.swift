
public extension MNDeviceKit.ScreenSize {
    
    
    public static var isZoomed: Bool {
        if UIScreen.main.scale == 3.0 {
            return UIScreen.main.nativeScale > 2.7
        } else {
            return UIScreen.main.nativeScale > UIScreen.main.scale
        }
    }
    

}




extension MNDeviceKit.ScreenSizeiPhone {
    
    /// Enum representation of various iOS screen sizes.
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
    
    
    /// Get the current device's screen height.
    public static let screenHeight = UIScreen.main.bounds.size.height
    
    /// Get the current device's screen width.
    public static let screenWidth = UIScreen.main.bounds.size.width
    
    /// Check if device screen size is equal a specific screen size
    ///
    /// - Parameter size: The size to check against.
    /// - Returns: Returns a Bool value the indicates the screen size is equal to the specified size.
    public static func `is`(_ size: Sizes) -> Bool {
        
        return UIScreen.main.bounds.size.height == size.rawValue
    }
    
    
    /// Check if device screen size is larger or equal to a specific screen size
    ///
    /// - Parameter size: The size to check against.
    /// - Returns: Returns a Bool value the indicates the screen size is larger or equal to the specified size.
    public static func isLargerOrEqual(_ size: Sizes) -> Bool {
        
        return UIScreen.main.bounds.size.height >= size.rawValue
    }
    
    
    /// Check if device screen size is smaller or equal to a specific screen size
    ///
    /// - Parameter size: The size to check against.
    /// - Returns: Returns a Bool value the indicates the screen size is smaller or equal to the specified size.
    public static func isSmallerOrEqual(_ size: Sizes) -> Bool {
        
        return UIScreen.main.bounds.size.height <= size.rawValue
    }
    
}


public extension UIScreen {

    /// Get the device's screen size as a `ScreenSize` object.
    public var screenSize: ScreenSize {
        
        return UIDevice.current.deviceModel.screenSize
    }
    
    /// Get the device's aspect ratio as a `AspectRatio` object.
    public var aspectRatio: AspectRatio {
        
        return UIDevice.current.deviceModel.aspectRatio
    }
    



}



