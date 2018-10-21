public extension String {

    /// Determine whether the string is a valid Hex.
    ///
    /// - Returns: Returns a Bool value indicating the string is a valid Hex.
    public var isHex: Bool {

        let chars = CharacterSet(charactersIn: "0123456789ABCDEF")
        guard uppercased().rangeOfCharacter(from: chars) != nil else {
            return false
        }
        return true
    }

}
