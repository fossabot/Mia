import UIKit


public extension UIColor {

    /// Used to describe the context of display of 2 colors. Based on WCAG: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#visual-audio-contrast-contrast
    public enum ContrastDisplayContext {

        case standard

        case standardLargeText

        case enhanced

        case enhancedLargeText

        var minimumContrastRatio: CGFloat {
            switch self {
                case .standard:
                    return 4.5
                case .standardLargeText:
                    return 3
                case .enhanced:
                    return 7
                case .enhancedLargeText:
                    return 4.5
            }
        }
    }


    /// Determines if the UIColor is light.
    public final var isLight: Bool {
        let rgb = rgbaComponents
        return ((rgb.r * 299) + (rgb.g * 587) + (rgb.b * 114)) / 1000 >= 0.5
    }

    /// Determines if the UIColor is dark.
    public final var isDark: Bool {
        let rgb = rgbaComponents
        return (0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b) < 0.5
    }


    /// Determines if the UIColor is black or white.
    public final var isBlackOrWhite: Bool {
        let rgb = rgbaComponents
        return (rgb.r > 0.91 && rgb.g > 0.91 && rgb.b > 0.91) || (rgb.r < 0.09 && rgb.g < 0.09 && rgb.b < 0.09)
    }

    /// Determines if the UIColor is black.
    public final var isBlack: Bool {
        let rgb = rgbaComponents
        return (rgb.r < 0.09 && rgb.g < 0.09 && rgb.b < 0.09)
    }

    /// Determines if the UIColor is white.
    public final var isWhite: Bool {
        let rgb = rgbaComponents
        return (rgb.r > 0.91 && rgb.g > 0.91 && rgb.b > 0.91)
    }

    /// A float value representing the luminance of the current color. May vary from 0 to 1.0.
    /// Learn More: https://www.w3.org/TR/WCAG20/#relativeluminancedef
    public final var luminance: CGFloat {
        let components = rgbaComponents
        let componentsArray = [ components.r, components.g, components.b ].map { (val) -> CGFloat in
            guard val <= 0.03928 else { return pow((val + 0.055) / 1.055, 2.4) }
            return val / 12.92
        }
        return (0.2126 * componentsArray[0]) + (0.7152 * componentsArray[1]) + (0.0722 * componentsArray[2])
    }


    /// Returns a float value representing the contrast ratio between 2 colors.
    /// Learn More: https://www.w3.org/TR/WCAG20-TECHS/G18.html
    ///
    /// - Parameter otherColor: The other color to compare with.
    /// - Returns: A CGFloat representing contrast value
    public func contrastRatio(with otherColor: UIColor) -> CGFloat {

        let otherLuminance = otherColor.luminance

        let l1 = max(luminance, otherLuminance)
        let l2 = min(luminance, otherLuminance)

        return (l1 + 0.05) / (l2 + 0.05)
    }


    /// Indicates if two colors are contrasting.
    /// Learn More: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#visual-audio-contrast-contrast
    ///
    /// - Parameters:
    ///   - otherColor: The other color to compare with.
    ///   - context: An optional context to determine the minimum acceptable contrast ratio. Defaults to .standard.
    /// - Returns: True if the contrast ratio exceed the minimum acceptable ratio.
    public func isContrasting(with otherColor: UIColor, inContext context: ContrastDisplayContext = .standard) -> Bool {

        return self.contrastRatio(with: otherColor) > context.minimumContrastRatio
    }


    public func isDistinctFrom(_ color: UIColor) -> Bool {

        let bg = rgbaComponents
        let fg = color.rgbaComponents
        let threshold: CGFloat = 0.25
        var result = false

        if fabs(bg.r - fg.r) > threshold || fabs(bg.g - fg.g) > threshold || fabs(bg.b - fg.b) > threshold {
            if fabs(bg.r - bg.g) < 0.03 && fabs(bg.r - bg.b) < 0.03 {
                if fabs(fg.r - fg.g) < 0.03 && fabs(fg.r - fg.b) < 0.03 {
                    result = false
                }
            }
            result = true
        }

        return result
    }


    public func isContrastingWith(_ color: UIColor) -> Bool {

        let bg = rgbaComponents
        let fg = color.rgbaComponents

        let bgLum = 0.2126 * bg.r + 0.7152 * bg.g + 0.0722 * bg.b
        let fgLum = 0.2126 * fg.r + 0.7152 * fg.g + 0.0722 * fg.b
        let contrast = bgLum > fgLum
                ? (bgLum + 0.05) / (fgLum + 0.05)
                : (fgLum + 0.05) / (bgLum + 0.05)

        return 1.6 < contrast
    }

}
