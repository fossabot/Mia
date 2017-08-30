import UIKit


public extension String {

    public func isHexValue() -> Bool {

        let chars = CharacterSet(charactersIn: "0123456789ABCDEF")

        guard uppercased().rangeOfCharacter(from: chars) != nil else {
            return false
        }
        return true
    }

}
