// MARK: -
extension FontKit {
    public enum Font: String, FontRepresentable {

        // Font Family: Roboto
        case robotoBlack = "Roboto-Black"
        case robotoBlackItalic = "Roboto-BlackItalic"
        case robotoBold = "Roboto-Bold"
        case robotoBoldItalic = "Roboto-BoldItalic"
        case robotoMedium = "Roboto-Medium"
        case robotoMediumItalic = "Roboto-MediumItalic"
        case robotoRegular = "Roboto-Regular"
        case robotoItalic = "Roboto-Italic"
        case robotoThin = "Roboto-Thin"
        case robotoThinItalic = "Roboto-ThinItalic"
        case robotoLight = "Roboto-Light"
        case robotoLightItalic = "Roboto-LightItalic"

        // Font Family: Roboto Monospace
        case robotoMonoBold = "RobotoMono-Bold"
        case robotoMonoBoldItalic = "RobotoMono-BoldItalic"
        case robotoMonoMedium = "RobotoMono-Medium"
        case robotoMonoMediumItalic = "RobotoMono-MediumItalic"
        case robotoMonoRegular = "RobotoMono-Regular"
        case robotoMonoItalic = "RobotoMono-Italic"
        case robotoMonoThin = "RobotoMono-Thin"
        case robotoMonoThinItalic = "RobotoMono-ThinItalic"
        case robotoMonoLight = "RobotoMono-Light"
        case robotoMonoLightItalic = "RobotoMono-LightItalic"

        // Font Family: Roboto Condensed
        case robotoCondensedBold = "RobotoCondensed-Bold"
        case robotoCondensedBoldItalic = "RobotoCondensed-BoldItalic"
        case robotoCondensedRegular = "RobotoCondensed-Regular"
        case robotoCondensedItalic = "RobotoCondensed-Italic"
        case robotoCondensedLight = "RobotoCondensed-Light"
        case robotoCondensedLightItalic = "RobotoCondensed-LightItalic"

        // Font Family: Roboto Condensed
        case robotoSlabBold = "RobotoSlab-Bold"
        case robotoSlabRegular = "RobotoSlab-Regular"
        case robotoSlabLight = "RobotoSlab-Light"
        case robotoSlabThin = "RobotoSlab-Thin"
    }
}

// MARK: -
public protocol FontRepresentable: RawRepresentable {
}

extension FontRepresentable where Self.RawValue == String {

    /// Initializes and return a `UIFont` using a FontKit.Font` value.
    /// Returns `systemFont` if custom font is unavailable.
    ///
    /// - Parameter size: The size of the font.
    /// - Returns: A `UIFont` from `FontKit.Font`. Returns `systemFont` if custom font is unavailable.
    public func of(size: CGFloat) -> UIFont {

        if let font = UIFont(name: rawValue, size: size) {
            return font
        }

        FontKit.debug(message: "Unable to load \(self.rawValue)... using system font instead")
        return UIFont.systemFont(ofSize: size)
    }

    private static func makeSize(size: Float) -> CGFloat {

        if Device.isPad {
            return CGFloat(size * FontKit.Configuration.iPadScaleFactor)
        }
        return CGFloat(size)
    }
}
