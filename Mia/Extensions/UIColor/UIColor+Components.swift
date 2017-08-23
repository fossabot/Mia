import UIKit


public typealias RGBAComponentsType = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
public typealias HSBAComponentsType = (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)
public typealias HSLComponentsType = (h: CGFloat, s: CGFloat, l: CGFloat)
public typealias LABComponentsType = (l: CGFloat, a: CGFloat, b: CGFloat)
public typealias XYZComponentsType = (x: CGFloat, y: CGFloat, z: CGFloat)


public extension UIColor {

    // MARK: - RGBA Components

    /// Returns an object with UIColor's RGBA components.
    public var rgbaComponents: RGBAComponentsType {

        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r: r, g: g, b: b, a: a)
    }

    /// The red component.
    public var redComponent: CGFloat {
        return rgbaComponents.r
    }

    /// The green component.
    public var greenComponent: CGFloat {
        return rgbaComponents.g
    }

    /// The blue component.
    public var blueComponent: CGFloat {
        return rgbaComponents.b
    }

    /// The alpha component.
    public var alphaComponent: CGFloat {
        return rgbaComponents.a
    }

    // MARK: - HSBA Components

    /// Returns an object with UIColor's HSBA components.
    public var hsbaComponents: HSBAComponentsType {

        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }

    /// The hue component.
    public var hueComponent: CGFloat {
        return hsbaComponents.h
    }

    /// The saturation component.
    public var saturationComponent: CGFloat {
        return hsbaComponents.s
    }

    /// The brightness component.
    public var brightnessComponent: CGFloat {
        return hsbaComponents.b
    }

    // MARK: - Lab Components

    /// Returns an object with UIColor's LAB (lightness, red-green axis, yellow-blue axis) components.
    /// It is based on the CIE XYZ color space with an observer at 2° and a D65 illuminant.
    /// Notes that L values are between 0 to 100.0, a values are between -128 to 127.0 and b values are between -128 to 127.0.
    public var labComponents: LABComponentsType {
        let normalized = { (c: CGFloat) -> CGFloat in
            c > 0.008856 ? pow(c, 1.0 / 3) : 7.787 * c + 16.0 / 116
        }

        let xyz = xyzComponents
        let normalizedX = normalized(xyz.x / 95.05)
        let normalizedY = normalized(xyz.y / 100)
        let normalizedZ = normalized(xyz.z / 108.9)

        let l = roundDecimal(116 * normalizedY - 16, precision: 1000)
        let a = roundDecimal(500 * (normalizedX - normalizedY), precision: 1000)
        let b = roundDecimal(200 * (normalizedY - normalizedZ), precision: 1000)

        return (l: l, a: a, b: b)
    }

    // MARK: - XYZ Components

    /// Returns an object with UIColor's XYZ (lightness, red-green axis, yellow-blue axis) components.
    /// It is based on an observer at 2° and a D65 illuminant.
    /// Notes that X values are between 0 to 95.05, Y values are between 0 to 100.0 and Z values are between 0 to 108.9.
    public var xyzComponents: XYZComponentsType {
        let toSRGB = { (c: CGFloat) -> CGFloat in
            c > 0.04045 ? pow((c + 0.055) / 1.055, 2.4) : c / 12.92
        }

        let rgba = rgbaComponents
        let red = toSRGB(rgba.r)
        let green = toSRGB(rgba.g)
        let blue = toSRGB(rgba.b)

        let x = roundDecimal((red * 0.4124 + green * 0.3576 + blue * 0.1805) * 100, precision: 1000)
        let y = roundDecimal((red * 0.2126 + green * 0.7152 + blue * 0.0722) * 100, precision: 1000)
        let z = roundDecimal((red * 0.0193 + green * 0.1192 + blue * 0.9505) * 100, precision: 1000)

        return (x: x, y: y, z: z)
    }

    // MARK: - HSL Components

    /// Returns the UIColor's HSL (hue, saturation, lightness) components.
    /// Notes that the hue value is between 0.0 and 360.0 degree.
    public var hslComponents: HSLComponentsType {
        let hsl = HSL(color: self)
        return (hsl.h * 360, hsl.s, hsl.l)
    }
}

