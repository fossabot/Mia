import UIKit


public extension Array where Element: UIColor {

    /// Returns the color palette of `amount` elements by grabbing equidistant colors.
    ///
    /// - Parameters:
    ///   - amount: An amount of colors to return. Defaults to 2.
    ///   - colorspace: The color space used to mix the colors. Defaults to the RBG color space.
    /// - Returns: An array of UIColor objects with equi-distant space in the gradient.
    public func colorPalette(amount: UInt = 2, inColorSpace colorspace: UIColorSpace = .rgb) -> [UIColor] {

        guard amount > 0 && self.count > 0 else {
            return []
        }

        guard self.count > 1 else {
            return (0..<amount).map { _ in self[0] }
        }

        let increment = 1 / CGFloat(amount - 1)

        return (0..<amount).map { pickColorAt(scale: CGFloat($0) * increment, inColorSpace: colorspace) }
    }


    /// Picks up and returns the color at the given scale by interpolating the colors.
    /// For example, given this color array `[red, green, blue]` and a scale of `0.25` you will get a kaki color.
    ///
    /// - Parameters:
    ///   - scale: The scale value between 0.0 and 1.0.
    ///   - colorspace: The color space used to mix the colors. Defaults to the RBG color space.
    /// - Returns: A UIColor object corresponding to the color at the given scale.
    public func pickColorAt(scale: CGFloat, inColorSpace colorspace: UIColorSpace = .rgb) -> UIColor {

        guard self.count > 1 else {
            return self.first ?? .black
        }

        let clippedScale = clip(scale, 0, 1)
        let positions = (0..<self.count).map { CGFloat($0) / CGFloat(self.count - 1) }

        var color: UIColor = .black

        for (index, position) in positions.enumerated() {
            guard clippedScale <= position else { continue }

            guard clippedScale != 0 && clippedScale != 1 else {
                return self[index]
            }

            let previousPosition = positions[index - 1]
            let weight = (clippedScale - previousPosition) / (position - previousPosition)

            color = self[index - 1].mixed(with: self[index], weight: weight, inColorSpace: colorspace)

            break
        }

        return color
    }


    public func gradient(_ transform: ((_ gradient: inout CAGradientLayer) -> CAGradientLayer)? = nil) -> CAGradientLayer {

        var gradient = CAGradientLayer()
        gradient.colors = self.map { $0.cgColor }

        if let transform = transform {
            gradient = transform(&gradient)
        }

        return gradient
    }

}
