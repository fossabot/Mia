//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"





public extension UIColor {
    
    
    
    public var hexString: String {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    }
    
    
    
    
    

    
    /// Takes a hex UInt and returns a UIColor.
    ///
    /// - Parameter hex: The hex value representing the color. Example: `0xFF0000`.
    public convenience init(hexValue: UInt32) {
        
        switch String(describing: hexValue).characters.count {
        case 4:
            self.init(red: CGFloat((hexValue & 0xF00) >> 8) / 15.0,
                      green: CGFloat((hexValue & 0x0F0) >> 4) / 15.0,
                      blue: CGFloat(hexValue & 0x00F) / 15.0,
                      alpha: 1.0)
            
        case 5:
            self.init(red: CGFloat((hexValue & 0xF000) >> 12) / 15.0,
                      green: CGFloat((hexValue & 0x0F00) >> 8) / 15.0,
                      blue: CGFloat((hexValue & 0x00F0) >> 4) / 15.0,
                      alpha: CGFloat(hexValue & 0x000F) / 15.0)
            
        case 8:
            self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                      alpha: 1.0)
            
        case 10:
            self.init(red: CGFloat((hexValue & 0xFF000000) >> 24) / 255.0,
                      green: CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0,
                      blue: CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0,
                      alpha: CGFloat(hexValue & 0x000000FF) / 255.0)
            
        default:
            fatalError("Failed to return UIColor from hex: \(hexValue)")
        }
        
    }
    

    
    
    
}


