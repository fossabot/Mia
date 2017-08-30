import UIKit


/// Clips the values in an interval.
///
/// - Parameters:
///   - v: The value to clipped.
///   - minimum: The minimum edge value.
///   - maximum: The maximum edge value.
/// - Returns: The clipped value.
internal func clip<T:Comparable>(_ v: T, _ minimum: T, _ maximum: T) -> T {

    return max(min(v, maximum), minimum)
}


/// Get the absolute value of the modulo operation.
///
/// - Parameters:
///   - x: The value to compute.
///   - m: Parameter m: The modulo.
/// - Returns: The absolute value of the modulo operation.

internal func modulo(_ x: CGFloat, m: CGFloat) -> CGFloat {

    return (x.truncatingRemainder(dividingBy: m) + m).truncatingRemainder(dividingBy: m)
}


/// Rounds the given float to a given decimal precision.
///
/// - Parameters:
///   - x: The value to round.
///   - precision: The precision. Default to 10000.
/// - Returns: The rounded number
internal func roundDecimal(_ x: CGFloat, precision: CGFloat = 10000) -> CGFloat {

    return CGFloat(Int(round(x * precision))) / precision
}


/// Hue-saturation-lightness structure to make the color manipulation easier.
struct HSL {

    /// Hue value between 0.0 and 1.0 (0.0 = 0 degree, 1.0 = 360 degree).
    var h: CGFloat = 0

    /// Saturation value between 0.0 and 1.0.
    var s: CGFloat = 0

    /// Lightness value between 0.0 and 1.0.
    var l: CGFloat = 0

    /// Alpha value between 0.0 and 1.0.
    var a: CGFloat = 1

    // MARK: - Initializing HSL Colors

    /// Initializes and creates a HSL color from the hue, saturation, lightness and alpha components.
    ///
    /// - Parameters:
    ///   - hue: The hue component of the color object, specified as a value between 0.0 and 360.0 degree.
    ///   - saturation: The saturation component of the color object, specified as a value between 0.0 and 1.0.
    ///   - lightness: The lightness component of the color object, specified as a value between 0.0 and 1.0.
    ///   - alpha: The opacity component of the color object, specified as a value between 0.0 and 1.0.
    init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1) {

        h = hue.truncatingRemainder(dividingBy: 360) / 360
        s = clip(saturation, 0, 1)
        l = clip(lightness, 0, 1)
        a = clip(alpha, 0, 1)
    }


    /// Initializes and creates a HSL (hue, saturation, lightness) color from a UIColor object.
    ///
    /// - Parameter color: A UIColor object.
    init(color: UIColor) {

        let rgba = color.rgbaComponents

        let maximum = max(rgba.r, max(rgba.g, rgba.b))
        let mininimum = min(rgba.r, min(rgba.g, rgba.b))

        let delta = maximum - mininimum

        h = 0
        s = 0
        l = (maximum + mininimum) / 2

        if delta != 0 {
            if l < 0.5 {
                s = delta / (maximum + mininimum)
            } else {
                s = delta / (2 - maximum - mininimum)
            }

            if rgba.r == maximum {
                h = (rgba.g - rgba.b) / delta + (rgba.g < rgba.b ? 6 : 0)
            } else if rgba.g == maximum {
                h = (rgba.b - rgba.r) / delta + 2
            } else if rgba.b == maximum {
                h = (rgba.r - rgba.g) / delta + 4
            }
        }

        h /= 6
        a = rgba.a
    }


    // MARK: - Transforming HSL Color

    /// Returns the UIColor representation from the current HSV color.
    ///
    /// - Returns: A UIColor object corresponding to the current HSV color.
    func toUIColor() -> UIColor {

        let m2 = l <= 0.5 ? l * (s + 1) : (l + s) - (l * s)
        let m1 = (l * 2) - m2

        let r = hueToRGB(m1: m1, m2: m2, h: h + 1 / 3)
        let g = hueToRGB(m1: m1, m2: m2, h: h)
        let b = hueToRGB(m1: m1, m2: m2, h: h - 1 / 3)

        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(a))
    }


    /// Hue to RGB helper function
    private func hueToRGB(m1: CGFloat, m2: CGFloat, h: CGFloat) -> CGFloat {

        let hue = modulo(h, m: 1)

        if hue * 6 < 1 {
            return m1 + (m2 - m1) * hue * 6
        } else if hue * 2 < 1 {
            return CGFloat(m2)
        } else if hue * 3 < 1.9999 {
            return m1 + (m2 - m1) * (2 / 3 - hue) * 6
        }

        return CGFloat(m1)
    }


    // MARK: - Deriving the Color

    /// Returns a color with the hue rotated along the color wheel by the given amount.
    ///
    /// - Parameter amount: A float representing the number of degrees as ratio (usually between -360.0 degree and 360.0 degree).
    /// - Returns: A HSL color with the hue changed.
    func adjustedHue(amount: CGFloat) -> HSL {

        return HSL(hue: h * 360 + amount, saturation: s, lightness: l, alpha: a)
    }


    /// Returns a color with the lightness increased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0.
    /// - Returns: A lighter HSL color.
    func lighter(amount: CGFloat) -> HSL {

        return HSL(hue: h * 360, saturation: s, lightness: l + amount, alpha: a)
    }


    /// Returns a color with the lightness decreased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0.
    /// - Returns: A darker HSL color.
    func darkened(amount: CGFloat) -> HSL {

        return lighter(amount: amount * -1)
    }


    /// Returns a color with the saturation increased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0.
    /// - Returns: A HSL color more saturated.
    func saturated(amount: CGFloat) -> HSL {

        return HSL(hue: h * 360, saturation: s + amount, lightness: l, alpha: a)
    }


    /// Returns a color with the saturation decreased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0.
    /// - Returns: A HSL color less saturated.
    func desaturated(amount: CGFloat) -> HSL {

        return saturated(amount: amount * -1)
    }

}


