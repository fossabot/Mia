// MARK: -
public protocol FontRepresentable: RawRepresentable {
}

extension FontRepresentable where Self.RawValue == String {

    /// Initializes and return a `UIFont` using a FontKit.Font` value.
    /// Returns `systemFont` if custom font is unavailable.
    ///
    /// - Parameter
    ///   - size: The size of the font.
    ///   - scalable: Determines if the size parameter will be scaled for device.
    /// - Returns: A `UIFont` from `FontKit.Font`. Returns `systemFont` if custom font is unavailable.
    public func of(size: CGFloat, scalable: Bool = false) -> UIFont {

        let size = scalable ? FontKit.scale(size: size) : size
        if let font = UIFont(name: rawValue, size: size) {
            return font
        }

        FontKit.debug(message: "Unable to load \(self.rawValue)... using system font instead")
        return UIFont.systemFont(ofSize: size)
    }
}
