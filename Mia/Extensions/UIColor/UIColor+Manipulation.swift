import UIKit


/// The supported color spaces for mixing colors.
public enum UIColorSpace {
    /// The RGB color space
    case rgb
    /// The Cie L*a*b* color space
    case lab
    /// The HSL color space
    case hsl
    /// The HSB color space
    case hsb

}


// MARK: - A collection of UIColor manipulation methods.
public extension UIColor {


    // MARK: -

    /// Creates and return a color where the red, green, and blue values are inverted, while the alpha channel is left alone.
    ///
    /// - Returns: An inverse (negative) of the original color.
    public final func inverted() -> UIColor {

        let rgba = rgbaComponents

        let invertedRed = 1 - rgba.r
        let invertedGreen = 1 - rgba.g
        let invertedBlue = 1 - rgba.b

        return UIColor(red: invertedRed, green: invertedGreen, blue: invertedBlue, alpha: rgba.a)
    }


    // MARK: - Hue Manipulation

    /// Creates and returns a UIColor with the hue rotated along the color wheel by the given amount.
    ///
    /// - Parameter amount: A CGFloat representing the number of degrees between -360.0 and 360.0.
    /// - Returns: A UIColor with the hue changed.
    public final func adjustedHue(amount: CGFloat) -> UIColor {

        return HSL(color: self).adjustedHue(amount: amount).toUIColor()
    }


    /// Creates and returns a UIColor with the complemented color. Results are identical to 'adjustedHue(amount: 180)'.
    ///
    /// - Returns: A complementary UIColor.
    public final func complemented() -> UIColor {

        return adjustedHue(amount: 180)
    }


    // MARK: - Lightness Manipulation

    /// Creates and returns a UIColor with the lightness increased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A lighter UIColor.
    public final func lighten(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).lighter(amount: amount).toUIColor()
    }


    /// Creates and returns a UIColor with the lightness decreased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A darker UIColor.
    public final func darken(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).darkened(amount: amount).toUIColor()
    }


    // MARK: - Saturation Manipulation

    /// Creates and returns a UIColor with the saturation increased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A more saturated UIColor.
    public final func saturate(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).saturated(amount: amount).toUIColor()
    }


    /// Creates and returns a UIColor with the saturation decreased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A less saturated UIColor.
    public final func desaturate(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).desaturated(amount: amount).toUIColor()
    }


    /// Creates and returns a UIColor converted to grayscale. Results are identical to 'desaturateColor(1)'.
    ///
    /// - Returns: A grayscale UIColor.
    public final func grayscale() -> UIColor {

        return desaturate(amount: 1)
    }


    // MARK: -  Alpha Manipulation

    /// Creates and returns a UIColor by adding the alpha value to the current color.
    ///
    /// - Parameter value: The alpha amount to add. Values must be between 0.0 and 1.0
    /// - Returns: A UIColor with the new alpha.
    public final func alpha(adjustedBy value: CGFloat) -> UIColor {

        let components = rgbaComponents
        let normalizedAlpha = clip(components.a + value, 0, 1)

        return withAlphaComponent(normalizedAlpha)
    }


    /// Creates and returns a UIColor with the given alpha value.
    ///
    /// - Parameter value: The alpha amount. Values must be between 0.0 and 1.0
    /// - Returns: A UIColor with the new alpha.
    public final func alpha(with value: CGFloat) -> UIColor {

        return withAlphaComponent(value)
    }


    // MARK: - Mixing Colors

    /// Creates and returns a UIColor by mixing the given UIColor.
    /// Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage.
    ///
    /// - Parameters:
    ///   - color: A UIColor to mix with.
    ///   - weight: The weighted value between 0.0 and 1.0. Defaults to 0.5, which means that half of both UIColors would be used.
    ///   - colorspace: The color space used to mix the colors. Defaults to the RBG color space.
    /// - Returns: A mixed UIColor.
    public final func mixed(with color: UIColor, weight: CGFloat = 0.5, inColorSpace colorspace: UIColorSpace = .rgb) -> UIColor {

        let normalizedWeight = clip(weight, 0, 1)

        switch colorspace {
            case .rgb:
                return mixedRGB(withColor: color, weight: normalizedWeight)
            case .lab:
                return mixedLab(withColor: color, weight: normalizedWeight)
            case .hsl:
                return mixedHSL(withColor: color, weight: normalizedWeight)
            case .hsb:
                return mixedHSB(withColor: color, weight: normalizedWeight)

        }
    }


    /// Creates and returns a UIColor corresponding to the mix of the receiver and an amount of white color, which increases lightness.
    ///
    /// - Parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
    /// - Returns: A lighter UIColor.
    public final func frosted(amount: CGFloat = 0.2) -> UIColor {

        return mixed(with: .white, weight: amount)
    }


    /// Creates and returns a UIColor corresponding to the mix of the receiver and an amount of black color, which reduces lightness.
    ///
    /// - Parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
    /// - Returns: A darker UIColor.
    public final func shaded(amount: CGFloat = 0.2) -> UIColor {

        return mixed(with: .black, weight: amount)
    }


    // MARK: Internal

    private func mixedRGB(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = rgbaComponents
        let c2 = color.rgbaComponents

        let red = c1.r + weight * (c2.r - c1.r)
        let green = c1.g + weight * (c2.g - c1.g)
        let blue = c1.b + weight * (c2.b - c1.b)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }


    private func mixedLab(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = labComponents
        let c2 = color.labComponents

        let l = c1.l + weight * (c2.l - c1.l)
        let a = c1.a + weight * (c2.a - c1.a)
        let b = c1.b + weight * (c2.b - c1.b)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(l: l, a: a, b: b, alpha: alpha)
    }


    private func mixedHSL(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = hslComponents
        let c2 = color.hslComponents

        let h = c1.h + weight * mixedHue(source: c1.h, target: c2.h)
        let s = c1.s + weight * (c2.s - c1.s)
        let l = c1.l + weight * (c2.l - c1.l)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(hue: h, saturation: s, lightness: l, alpha: alpha)
    }


    private func mixedHSB(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = hsbaComponents
        let c2 = color.hsbaComponents

        let h = c1.h + weight * mixedHue(source: c1.h, target: c2.h)
        let s = c1.s + weight * (c2.s - c1.s)
        let b = c1.b + weight * (c2.b - c1.b)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(hue: h, saturation: s, brightness: b, alpha: alpha)
    }


    private func mixedHue(source: CGFloat, target: CGFloat) -> CGFloat {

        if target > source && target - source > 180 {
            return target - source + 360
        } else if target < source && source - target > 180 {
            return target + 360 - source
        }

        return target - source
    }

}


