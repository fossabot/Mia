import UIKit


public extension UIView {

    /// Rotates a view to a specific value.
    ///
    /// - Parameters:
    ///   - value: The value to rotate the view.
    ///   - duration: The duration it takes to rotate the view. Defaults to 0.2.
    public func rotate(_ value: CGFloat, duration: CFTimeInterval = 0.2) {

        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = value
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards

        self.layer.add(animation, forKey: nil)
    }

}
