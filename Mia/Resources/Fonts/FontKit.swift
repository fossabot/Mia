// FontKit.Loader was inspired by https://github.com/ArtSabintsev/FontBlaster
// FontRepresentable was inspired by https://github.com/Nirma/UIFontComplete

// MARK: -
public struct FontKit {

    /// FontKit configurations.
    public struct Configuration {

        /// Toggles debug print statements. Defaults to false.
        public static var debugMode = false

        /// Scale factor for iPhone Plus & iPhone X. Defaults to 1.2.
        public static var mediumScaleFactor: CGFloat = 1.2

        /// Scale factor for iPads. Defaults to 1.5.
        public static var largeScaleFactor: CGFloat = 1.5
    }

    /// Prints debug messages to the console if debugEnabled is set to true.
    ///
    /// - Parameter message: The status to print to the console.
    static func debug(message: String) {

        Rosewood.Framework.print(framework: "FontKit", message: message, debugEnabled: Configuration.debugMode)
    }

    /// Return size for a specific device (iPhone/iPod or iPad)
    ///
    /// - Parameters:
    ///   - phone: Value for iPhones/iPods
    ///   - pad: Value for iPads.
    /// - Returns: The value for the current device.
    public static func sizeFor<T>(phone: T, pad: T) -> T {

        return (Device.isPad ? pad : phone)
    }

    /// Return size depending on specific screen family.
    /// Defaults to small value if device size cannot be determined.
    ///
    /// - Parameters:
    ///   - old: Value for 3.5 and 4.0 inch devices.
    ///   - small: Value for 4.7 inch devices.
    ///   - medium: Value for 5.5, 5.8, and 7.9 inch devices.
    ///   - large: Value for 9.7, 10.5 and 12.9 inch devices (iPads).
    /// - Returns: The value for the current device.
    public static func sizeFor<T>(old: T? = nil, small: T, medium: T, large: T) -> T {

        let family = Device.Screen.family

        switch family {
            case .old: return old ?? small
            case .small: return small
            case .medium: return medium
            case .large: return large
            default: return small
        }
    }

    /// Return value for specific screen size.
    /// Defaults to nearest value if undefined.
    ///
    /// - Parameter sizes: Dictionary array representing [ScreenSize: Value] to check against
    /// - Returns: The value from the `size` parameter based on the current device.
    public static func sizeFor<T>(sizes: [ScreenSize: T]) -> T {

        let screen = Device.Screen.size
        var nearestValue: T?
        var distance = CGFloat.greatestFiniteMagnitude

        for (key, value) in sizes {
            if key == screen {
                return value
            }

            let actualDistance = fabs(key.rawValue - screen.rawValue)
            if actualDistance < distance {
                nearestValue = value
                distance = actualDistance
            }
        }

        return nearestValue!
    }

    public static func scale(size: CGFloat, byDevice: Bool = false) -> CGFloat {

        if byDevice {
            return sizeFor(phone: size, pad: size * FontKit.Configuration.largeScaleFactor)
        } else {
            return sizeFor(small: size, medium: size * FontKit.Configuration.mediumScaleFactor, large: size * FontKit.Configuration.largeScaleFactor)
        }
    }
}
