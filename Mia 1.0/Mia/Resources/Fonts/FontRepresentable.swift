// MARK: -
public protocol FontRepresentable: RawRepresentable {
}

extension FontRepresentable where Self.RawValue == String {

    /// Initializes and return a `UIFont` using the `FontRepresentable` value.
    ///
    /// - Parameter
    ///   - size: The size of the font to use.
    ///   - willScale: Determines if the size will be scaled for device.
    /// - Returns: The `UIFont`. Returns `systemFont` if custom font is unavailable.
    public func of(size: CGFloat, willScale: Bool = false) -> UIFont {

//        let newSize = willScale ? Scale.size(size) : size
        if let font = UIFont(name: rawValue, size: size) {
            return font
        }

        FontKit.debug(message: "Unable to load \(self.rawValue)... using system font instead")
        return UIFont.systemFont(ofSize: size)
    }
}
