// MARK: -

public extension Device.Screen {

    /// Determines whether the screen is retina
    public static var size: ScreenSize {
        return ScreenSize()
    }

    /// Return screen family
    public static var family: ScreenFamily {
        return ScreenFamily()
    }

    /// Detect screen resolution scale.
    public static var scale: ScreenScale {
        return ScreenScale()
    }

    /// Determines whether the screen is retina
    public static var isRetina: Bool {
        return scale > .x1
    }

    /// Determines whether the screen is zoomed
    public static var isZoomed: Bool {
        if scale == .x3 {
            return UIScreen.main.nativeScale > 2.7
        } else {
            return UIScreen.main.nativeScale > UIScreen.main.scale
        }
    }

    /// Determines whether the screen is in landscape interface orientation
    public static var isLandscape: Bool {
        return UIApplication.shared.statusBarOrientation == .landscapeLeft ||
               UIApplication.shared.statusBarOrientation == .landscapeRight
    }

    /// Determines whether the screen is in portrait interface orientation
    public static var isPortrait: Bool {
        return UIApplication.shared.statusBarOrientation == .portrait ||
               UIApplication.shared.statusBarOrientation == .portraitUpsideDown
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

    /// The screens pixel size
    public static var pixelSize: CGSize {
        let screenSize = UIScreen.main.bounds.size

        return CGSize(width: screenSize.width * scale.rawValue, height: screenSize.height * scale.rawValue)
    }
}


