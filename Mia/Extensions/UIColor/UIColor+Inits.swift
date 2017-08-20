import UIKit


public extension UIColor {

    /// Takes a hex with optional alpha value and returns a UIColor object.
    ///
    /// - Parameters:
    ///   - hex: The hex value representing the color. Example: 0x2E3944.
    ///   - alpha: The alpha value of the color you want returned. Defaults to 1.0.
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {

        self.init(
                red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat((hex & 0x0000FF) >> 0) / 255.0,
                alpha: alpha
        )
    }

}

