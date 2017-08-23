//
//  UIColor+Manipulation.swift
//  Pods
//
//  Created by Michael Hedaitulla on 8/21/17.
//
//

import UIKit


extension UIColor {

    /// Mixes the color with another color.
    ///
    /// - Parameters:
    ///   - color: The color to mix with.
    ///   - amount: The amount to mix the new color in. Values must be between 0.0 and 1.0
    /// - Returns: A UIColor instance representing the resulting color.
    public func mix(with color: UIColor, amount: Float) -> UIColor {

        var comp1: [CGFloat] = Array(repeating: 0, count: 4);
        self.getRed(&comp1[0], green: &comp1[1], blue: &comp1[2], alpha: &comp1[3])

        var comp2: [CGFloat] = Array(repeating: 0, count: 4);
        color.getRed(&comp2[0], green: &comp2[1], blue: &comp2[2], alpha: &comp2[3])

        var comp: [CGFloat] = Array(repeating: 0, count: 4);
        for i in 0...3 {
            comp[i] = comp1[i] + (comp2[i] - comp1[i]) * CGFloat(amount)
        }

        return UIColor(red: comp[0], green: comp[1], blue: comp[2], alpha: comp[3])
    }

    /// Creates a new color with the given alpha value.
    ///
    /// - Parameter value: The alpha amount. Values must be between 0.0 and 1.0
    /// - Returns: A UIColor instance with the new alpha.
    public func alpha(_ value: CGFloat) -> UIColor {

        return withAlphaComponent(value)
    }

    /// Creates a new color by adding the alpha value to the current color.
    ///
    /// - Parameter value: The alpha amount to add. Values must be between 0.0 and 1.0
    /// - Returns: A UIColor instance with the new alpha.
    public func adjustAlpha(_ value: CGFloat) -> UIColor {

        let components = rgbaComponents
        let normalizedAlpha = clip(components.a + value, 0, 1)

        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: normalizedAlpha)
    }

    /// Creates and returns a color object with the hue rotated along the color wheel by the given amount.
    ///
    /// - Parameter amount: A float representing the number of degrees as ratio (usually between -360.0 degree and 360.0 degree).
    /// - Returns: A UIColor object with the hue changed.
    public final func adjustedHue(amount: CGFloat) -> UIColor {

        return HSL(color: self).adjustedHue(amount: amount).toUIColor()
    }

    /// Creates and returns a color object with the lightness increased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A lighter UIColor.
    public final func lighter(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).lighter(amount: amount).toUIColor()
    }

    /// Creates and returns a color object with the lightness decreased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A darker UIColor.
    public final func darkened(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).darkened(amount: amount).toUIColor()
    }

    /// Creates and returns a color object with the saturation increased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A UIColor more saturated.
    public final func saturated(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).saturated(amount: amount).toUIColor()
    }

    /// Creates and returns a color object with the saturation decreased by the given amount.
    ///
    /// - Parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
    /// - Returns: A UIColor less saturated.
    public final func desaturated(amount: CGFloat = 0.2) -> UIColor {

        return HSL(color: self).desaturated(amount: amount).toUIColor()
    }

    /// Creates and returns a color object converted to grayscale. Results are identical to 'desaturateColor(1)'.
    ///
    /// - Returns: A grayscale UIColor.
    public final func grayscaled() -> UIColor {

        return desaturated(amount: 1)
    }

    /// Creates and returns the complement of the color object.
    ///
    /// - Returns: A complementary UIColor.
    public final func complemented() -> UIColor {

        return adjustedHue(amount: 180)
    }

    /// Creates and return a color object where the red, green, and blue values are inverted, while the alpha channel is left alone.
    ///
    /// - Returns: An inverse (negative) of the original color.
    public final func inverted() -> UIColor {

        let rgba = rgbaComponents

        let invertedRed = 1 - rgba.r
        let invertedGreen = 1 - rgba.g
        let invertedBlue = 1 - rgba.b

        return UIColor(red: invertedRed, green: invertedGreen, blue: invertedBlue, alpha: rgba.a)
    }

    /// Mixes the given color object with the receiver.
    /// Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage.
    ///
    /// - Parameters:
    ///   - color: A color object to mix with the receiver.
    ///   - weight: The weight specifies the amount of the given color object (between 0 and 1). The default value is 0.5, which means that half the given color and half the receiver color object should be used.
    ///   - colorspace: The color space used to mix the colors. By default it uses the RBG color space.
    /// - Returns: A color object corresponding to the two colors object mixed together.
    public final func mixed(withColor color: UIColor, weight: CGFloat = 0.5, inColorSpace colorspace: UIColorSpace = .rgb) -> UIColor {

        let normalizedWeight = clip(weight, 0, 1)

        switch colorspace {
            case .lab:
                return mixedLab(withColor: color, weight: normalizedWeight)
            case .hsl:
                return mixedHSL(withColor: color, weight: normalizedWeight)
            case .hsb:
                return mixedHSB(withColor: color, weight: normalizedWeight)
            case .rgb:
                return mixedRGB(withColor: color, weight: normalizedWeight)
        }
    }

    /// Creates and returns a color object corresponding to the mix of the receiver and an amount of white color, which increases lightness.
    ///
    /// - Parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
    /// - Returns: A lighter UIColor.
    public final func tinted(amount: CGFloat = 0.2) -> UIColor {

        return mixed(withColor: .white, weight: amount)
    }

    /// Creates and returns a color object corresponding to the mix of the receiver and an amount of black color, which reduces lightness.
    ///
    /// - Parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
    /// - Returns: A darker UIColor.
    public final func shaded(amount: CGFloat = 0.2) -> UIColor {

        return mixed(withColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1), weight: amount)
    }

    // MARK: - Internal

    func mixedLab(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = labComponents
        let c2 = color.labComponents

        let l = c1.l + weight * (c2.l - c1.l)
        let a = c1.a + weight * (c2.a - c1.a)
        let b = c1.b + weight * (c2.b - c1.b)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(l: l, a: a, b: b, alpha: alpha)
    }

    func mixedHSL(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = hslComponents
        let c2 = color.hslComponents

        let h = c1.h + weight * mixedHue(source: c1.h, target: c2.h)
        let s = c1.s + weight * (c2.s - c1.s)
        let l = c1.l + weight * (c2.l - c1.l)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(hue: h, saturation: s, lightness: l, alpha: alpha)
    }

    func mixedHSB(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = hsbaComponents
        let c2 = color.hsbaComponents

        let h = c1.h + weight * mixedHue(source: c1.h, target: c2.h)
        let s = c1.s + weight * (c2.s - c1.s)
        let b = c1.b + weight * (c2.b - c1.b)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(hue: h, saturation: s, brightness: b, alpha: alpha)
    }

    func mixedRGB(withColor color: UIColor, weight: CGFloat) -> UIColor {

        let c1 = rgbaComponents
        let c2 = color.rgbaComponents

        let red = c1.r + weight * (c2.r - c1.r)
        let green = c1.g + weight * (c2.g - c1.g)
        let blue = c1.b + weight * (c2.b - c1.b)
        let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    func mixedHue(source: CGFloat, target: CGFloat) -> CGFloat {

        if target > source && target - source > 180 {
            return target - source + 360
        } else if target < source && source - target > 180 {
            return target + 360 - source
        }

        return target - source
    }
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

        let hue = moda(h, m: 1)

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

