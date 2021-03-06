// MARK: -
extension FontKit {

    public enum Font: String, FontRepresentable {

        // MARK: *** Font Family: Roboto ***
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

        // MARK: *** Font Family: Roboto Monospace ***
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

        // MARK: *** Font Family: Roboto Condensed ***
        case robotoCondensedBold = "RobotoCondensed-Bold"
        case robotoCondensedBoldItalic = "RobotoCondensed-BoldItalic"
        case robotoCondensedRegular = "RobotoCondensed-Regular"
        case robotoCondensedItalic = "RobotoCondensed-Italic"
        case robotoCondensedLight = "RobotoCondensed-Light"
        case robotoCondensedLightItalic = "RobotoCondensed-LightItalic"

        // MARK: *** Font Family: Roboto Slab ***
        case robotoSlabBold = "RobotoSlab-Bold"
        case robotoSlabRegular = "RobotoSlab-Regular"
        case robotoSlabLight = "RobotoSlab-Light"
        case robotoSlabThin = "RobotoSlab-Thin"
    }
}


extension UIFont {

    public convenience init?(font: FontKit.Font, size: CGFloat) {
        let fontIdentifier: String = font.rawValue
        self.init(name: fontIdentifier, size: size)
    }
}
