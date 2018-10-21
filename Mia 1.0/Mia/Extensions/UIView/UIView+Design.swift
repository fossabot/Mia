import UIKit


public extension UIView {

    /// The views corner radius. Values must be between 0.0 and 1.0
    public var cornerRadiusRatio: CGFloat {
        get {
            return layer.cornerRadius / frame.width
        }

        set {

            if !(0.0...1.0 ~= newValue) {
                fatalError("Value must be between 0.0 and 1.0")
            }

            layer.masksToBounds = true

            let normalizedRatio = max(0.0, min(1.0, newValue))
            layer.cornerRadius = frame.width * normalizedRatio
        }
    }

}
