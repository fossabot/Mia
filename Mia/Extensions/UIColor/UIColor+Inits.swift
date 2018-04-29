import UIKit


// MARK: - A collection of UIColor initializations. 
public extension UIColor {

    // MARK: RGB

    /// Initializes and returns a UIColor using a red, green, blue and alpha value.
    /// Notes that values out of range are clipped
    ///
    /// - Parameters:
    ///   - r: The red component of the UIColor between 0.0 and 255.0.
    ///   - g: The green component of the UIColor between 0.0 and 255.0.
    ///   - b: The blue component of the UIColor between 0.0 and 255.0.
    ///   - a: The alpha component of the UIColor between 0.0 and 255.0. Defaults to 255.0.
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255) {

        self.init(red: clip(r, 0, 255) / 255, green: clip(g, 0, 255) / 255, blue: clip(b, 0, 255) / 255, alpha: clip(a, 0, 255) / 255)
    }


    // MARK: HSL

    /// Initializes and returns a UIColor using a hue, saturation, lightness and alpha value.
    ///
    /// - Parameters:
    ///   - hue: The hue component of the UIColor between 0.0 and 360.0 degrees.
    ///   - saturation: The saturation component of the UIColor between 0.0 and 1.0.
    ///   - lightness: The lightness component of the UIColor between 0.0 and 1.0.
    ///   - alpha: The alpha component of the UIColor between 0.0 and 1.0. Defaults to 1.0.
    public convenience init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1) {

        let color = HSL(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha).toUIColor()
        let components = color.rgbaComponents

        self.init(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }


    // MARK: Lab

    /// Initializes and returns a color using CIE XYZ color space component values with an observer at 2° and a D65 illuminant.
    /// Notes that values out of range are clipped
    ///
    /// - Parameters:
    ///   - l: The lightness, specified as a value from 0 to 100.0.
    ///   - a: The red-green axis, specified as a value from -128.0 to 127.0.
    ///   - b: The yellow-blue axis, specified as a value from -128.0 to 127.0.
    ///   - alpha: The opacity value of the UIColor, specified as a value from 0.0 to 1.0. Default to 1.0.
    public convenience init(l: CGFloat, a: CGFloat, b: CGFloat, alpha: CGFloat = 1) {

        let clippedL = clip(l, 0, 100)
        let clippedA = clip(a, -128, 127)
        let clippedB = clip(b, -128, 127)

        let normalized = { (c: CGFloat) -> CGFloat in
            pow(c, 3) > 0.008856 ? pow(c, 3) : (c - 16 / 116) / 7.787
        }

        let preY = (clippedL + 16) / 116
        let preX = clippedA / 500 + preY
        let preZ = preY - clippedB / 200

        let x = 95.05 * normalized(preX)
        let y = 100 * normalized(preY)
        let z = 108.9 * normalized(preZ)

        self.init(x: x, y: y, z: z, alpha: alpha)
    }


    // MARK: XYZ

    /// Initializes and returns a UIColor using CIE XYZ color space component values with an observer at 2° and a D65 illuminant.
    /// Notes that values out of range are clipped.
    ///
    /// - Parameters:
    ///   - x: The mix of cone response curves, specified as a value from 0 to 95.05.
    ///   - y: The luminance, specified as a value from 0 to 100.0.
    ///   - z: The quasi-equal to blue stimulation, specified as a value from 0 to 108.9.
    ///   - alpha: The opacity value of the UIColor, specified as a value from 0.0 to 1.0. Default to 1.0.
    public convenience init(x: CGFloat, y: CGFloat, z: CGFloat, alpha: CGFloat = 1) {

        let clippedX = clip(x, 0, 95.05) / 100
        let clippedY = clip(y, 0, 100) / 100
        let clippedZ = clip(z, 0, 108.9) / 100

        let toRGB = { (c: CGFloat) -> CGFloat in
            let rgb = c > 0.0031308 ? 1.055 * pow(c, 1 / 2.4) - 0.055 : c * 12.92

            return abs(roundDecimal(rgb, precision: 1000))
        }

        let red = toRGB(clippedX * 3.2406 + clippedY * -1.5372 + clippedZ * -0.4986)
        let green = toRGB(clippedX * -0.9689 + clippedY * 1.8758 + clippedZ * 0.0415)
        let blue = toRGB(clippedX * 0.0557 + clippedY * -0.2040 + clippedZ * 1.0570)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }


    // MARK: Hex

    /// Initializes and returns a UIColor fro a hex String.
    ///
    /// - Parameter hex: The hex string representing the color. Example: '#FF0000' or 'FF0000'.
    public convenience init(hexString: String) {

        var hexString = hexString
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        let scanner = Scanner(string: hexString)
        var hexValue: UInt32 = 0
        if scanner.scanHexInt32(&hexValue) {
            switch hexString.count {
                case 3:
                    self.init(red: CGFloat((hexValue & 0xF00) >> 8) / 15.0,
                              green: CGFloat((hexValue & 0x0F0) >> 4) / 15.0,
                              blue: CGFloat(hexValue & 0x00F) / 15.0,
                              alpha: 1.0)

                case 4:
                    self.init(red: CGFloat((hexValue & 0xF000) >> 12) / 15.0,
                              green: CGFloat((hexValue & 0x0F00) >> 8) / 15.0,
                              blue: CGFloat((hexValue & 0x00F0) >> 4) / 15.0,
                              alpha: CGFloat(hexValue & 0x000F) / 15.0)

                case 6:
                    self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                              green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                              blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                              alpha: 1.0)

                case 8:
                    self.init(red: CGFloat((hexValue & 0xFF000000) >> 24) / 255.0,
                              green: CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0,
                              blue: CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0,
                              alpha: CGFloat(hexValue & 0x000000FF) / 255.0)

                default:
                    fatalError("Failed to return UIColor from hex: \(hexValue)")
            }

        } else {
            fatalError("Failed to parse hex value \(hexString)")
        }
    }


    /// Initializes and returns a UIColor from a hex UInt.
    ///
    /// - Parameter hex: The hex value representing the color. Example: `0xF00`.
    public convenience init(hex3Value: UInt16, alpha: CGFloat = 1) {

        self.init(red: CGFloat((hex3Value & 0xF00) >> 8) / 15.0,
                  green: CGFloat((hex3Value & 0x0F0) >> 4) / 15.0,
                  blue: CGFloat(hex3Value & 0x00F) / 15.0,
                  alpha: alpha)
    }


    /// Initializes and returns a UIColor from a hex UInt.
    ///
    /// - Parameter hex: The hex value representing the color. Example: `0xF00F`.
    public convenience init(hex4Value: UInt16) {

        self.init(red: CGFloat((hex4Value & 0xF000) >> 12) / 15.0,
                  green: CGFloat((hex4Value & 0x0F00) >> 8) / 15.0,
                  blue: CGFloat((hex4Value & 0x00F0) >> 4) / 15.0,
                  alpha: CGFloat(hex4Value & 0x000F) / 15.0)
    }


    /// Initializes and returns a UIColor from a hex UInt.
    ///
    /// - Parameter hex: The hex value representing the color. Example: `0xFF0000`.
    public convenience init(hex6Value: UInt32, alpha: CGFloat = 1) {

        self.init(red: CGFloat((hex6Value & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex6Value & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hex6Value & 0x0000FF) / 255.0,
                  alpha: alpha)
    }


    /// Initializes and returns a UIColor from a hex UInt.
    ///
    /// - Parameter hex: The hex value representing the color. Example: `0xFF0000FF`.
    public convenience init(hex8Value: UInt32) {

        self.init(red: CGFloat((hex8Value & 0xFF000000) >> 24) / 255.0,
                  green: CGFloat((hex8Value & 0x00FF0000) >> 16) / 255.0,
                  blue: CGFloat((hex8Value & 0x0000FF00) >> 8) / 255.0,
                  alpha: CGFloat(hex8Value & 0x000000FF) / 255.0)
    }
    
    
    /// Initalize and return a UIColor generated from a seed string.
    ///
    /// - Parameter seed: The seed to use.
    public convenience init(seed: String) {
        /// Identical seeds will lead to identical colors
        /// randomColor(seed: "ben")
        /// randomColor(seed: "ben")
        ///
        /// Similarly, seeds with the same character values will lead to identical colors
        /// randomColor(seed: "ben")
        /// randomColor(seed: "neb")
        ///
        /// However, this works well enough for something like article titles
        /// randomColor(seed: "iPhone 7: Jet Black vs. Black")
        /// randomColor(seed: "Vesper, Adieu")
        
        var total: Int = 0
        for u in seed.unicodeScalars {
            total += Int(UInt32(u))
        }
        
        srand48(total * 200)
        let r = CGFloat(drand48())
        
        srand48(total)
        let g = CGFloat(drand48())
        
        srand48(total / 200)
        let b = CGFloat(drand48())
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }

}
