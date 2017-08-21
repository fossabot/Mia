import UIKit


public extension UIColor {

    /// Takes a hex String and returns a UIColor.
    ///
    /// - Parameter hex: The hex string representing the color. Example: '#FF0000' or 'FF0000'.
    public convenience init(hexString: String) {
        
        var hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
            hexString = hexString.substring(from: hexString.index(hexString.startIndex, offsetBy: 1))
        }
        
        var hexValue: UInt32 = 0
        if scanner.scanHexInt32(&hexValue) {
            switch hexString.characters.count {
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



