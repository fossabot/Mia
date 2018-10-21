import Foundation

// TODO: Replace with `localThreadSingleton`
extension NumberFormatter {

    static var cachedNumberFormatter = [ String: NumberFormatter ]()

    public static func cachedFormatter(_ numberstyle: Style) -> NumberFormatter {

        let hashKey = "\(numberstyle.hashValue)"
        if NumberFormatter.cachedNumberFormatter[hashKey] == nil {
            let formatter = NumberFormatter()
            formatter.numberStyle = numberstyle
            formatter.isLenient = true
            NumberFormatter.cachedNumberFormatter[hashKey] = formatter
        }
        return NumberFormatter.cachedNumberFormatter[hashKey]!
    }
}
