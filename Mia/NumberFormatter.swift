import Foundation


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

}


// MARK: - Double
public extension Double {

    // MARK: Currency Methods
    func currencyWithChange() -> String {

        guard let amount = NSDecimalNumber(value: self) as NSDecimalNumber! else {
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

        guard let amount = NSDecimalNumber(value: self) as NSDecimalNumber! else {
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

        guard let amount = NSDecimalNumber(value: self) as NSDecimalNumber! else {
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

        guard let amount = NSDecimalNumber(value: self) as NSDecimalNumber! else {
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

}
