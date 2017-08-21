import Foundation


// MARK: - Colors
public func UIColorFromRGB(_ rgbValue: String) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue.hexaToInt & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue.hexaToInt & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue.hexaToInt & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension String {
    var hexaToInt      : Int    { return Int(strtoul(self, nil, 16))      }
    var hexaToDouble   : Double { return Double(strtoul(self, nil, 16))   }
    var hexaToBinary   : String { return String(hexaToInt, radix: 2)      }
    var decimalToHexa  : String { return String(Int(self) ?? 0, radix: 16)}
    var decimalToBinary: String { return String(Int(self) ?? 0, radix: 2) }
    var binaryToInt    : Int    { return Int(strtoul(self, nil, 2))       }
    var binaryToDouble : Double { return Double(strtoul(self, nil, 2))   }
    var binaryToHexa   : String { return String(binaryToInt, radix: 16)  }
}

extension Int {
    var binaryString: String { return String(self, radix: 2)  }
    var hexaString  : String { return String(self, radix: 16) }
    var doubleValue : Double { return Double(self) }
}


// MARK: - String
public extension String {

    // MARK: Currency Methods
    func currencyWithChange() -> String {

        guard let amount = NSDecimalNumber(string: self) as NSDecimalNumber! else {
            return "-"
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.alwaysShowsDecimalSeparator = true

        return formatter.string(from: amount)!
    }

    func currencyWithoutChange() -> String {

        guard let amount = NSDecimalNumber(string: self) as NSDecimalNumber! else {
            return "-"
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.alwaysShowsDecimalSeparator = false

        return formatter.string(from: amount)!
    }

    // MARK: Number Methods
    func numberWithDecimal(_ decimalPlaces: Int = 2) -> String {

        guard let amount = NSDecimalNumber(string: self) as NSDecimalNumber! else {
            return "-"
        }
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        formatter.alwaysShowsDecimalSeparator = true

        return formatter.string(from: amount)!
    }

    func numberWithoutDecimal() -> String {

        guard let amount = NSDecimalNumber(string: self) as NSDecimalNumber! else {
            return "-"
        }

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.alwaysShowsDecimalSeparator = false

        return formatter.string(from: amount)!
    }

    func kValue() -> String {

        guard let amount = NSDecimalNumber(string: self) as NSDecimalNumber! else {
            return "-"
        }

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.alwaysShowsDecimalSeparator = false

        return "\(formatter.string(from: amount.dividing(by: NSDecimalNumber(value: 1000)))!)k"
    }

}


// MARK: - Double
public extension NSNumber {

    // MARK: Currency Methods
    func currencyWithChange(_ decimalPlaces: Int = 2) -> String {

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        formatter.alwaysShowsDecimalSeparator = true

        return formatter.string(from: self)!
    }

    func currencyWithoutChange() -> String {

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.alwaysShowsDecimalSeparator = false

        return formatter.string(from: self)!
    }

    // MARK: Number Methods
    func numberWithDecimal(_ decimalPlaces: Int = 2) -> String {

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        formatter.alwaysShowsDecimalSeparator = true

        return formatter.string(from: self)!
    }

    func numberWithoutDecimal() -> String {

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.alwaysShowsDecimalSeparator = false

        return formatter.string(from: self)!
    }

    func kValue(_ decimalPlaces: Int = 0) -> String {

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        formatter.alwaysShowsDecimalSeparator = false

        let value: Double = self.doubleValue
        let value2 = value / 1000

        return "\(formatter.string(from: NSNumber(value: value2))!)k"

    }

    func percentValue(_ decimalPlaces: Int = 0) -> String {

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        formatter.alwaysShowsDecimalSeparator = false

        return "\(formatter.string(from: self)!)%"
    }

}
