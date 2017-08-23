//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"





extension UIColor {
    
    public typealias RGBAComponentsType = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    
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
    
    public final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
        
    }
    
    public final func toHex() -> UInt32 {
        func roundToHex(_ x: CGFloat) -> UInt32 {
            return UInt32(roundf(Float(x) * 255.0))
        }
        
        let rgba       = toRGBAComponents()
        let colorToInt = roundToHex(rgba.r) << 24 | roundToHex(rgba.g) << 16 | roundToHex(rgba.b) << 8 | roundToHex(rgba.a)
        
        return colorToInt
    }
    
    public func alpha(_ value: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIColor(red: red, green: green, blue: blue, alpha: value)
    }
    
    
    /// Returns a string with the hex value of the current color and alpha.
    public var hexString: String {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    }
    
    public var hexString2: String {
        
        
        return String(format: "#%02X%02X%02X%02X", Int(self.redComponent * 255), Int(self.greenComponent * 255), Int(self.blueComponent * 255), Int(self.alphaComponent * 255))
    }
    
    
}



_ = UIColor.black.hexString
_ = UIColor.black.hexString2
_ = UIColor.black.toHex()

