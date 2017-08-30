import UIKit


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
    var hexaToInt: Int { return Int(strtoul(self, nil, 16)) }

    var hexaToDouble: Double { return Double(strtoul(self, nil, 16)) }

    var hexaToBinary: String { return String(hexaToInt, radix: 2) }

    var decimalToHexa: String { return String(Int(self) ?? 0, radix: 16) }

    var decimalToBinary: String { return String(Int(self) ?? 0, radix: 2) }

    var binaryToInt: Int { return Int(strtoul(self, nil, 2)) }

    var binaryToDouble: Double { return Double(strtoul(self, nil, 2)) }

    var binaryToHexa: String { return String(binaryToInt, radix: 16) }
}


extension Int {
    var binaryString: String { return String(self, radix: 2) }

    var hexaString: String { return String(self, radix: 16) }

    var doubleValue: Double { return Double(self) }
}


extension Double {
    public var millisecond: TimeInterval { return self / 1000 }

    public var milliseconds: TimeInterval { return self / 1000 }

    public var ms: TimeInterval { return self / 1000 }

    public var second: TimeInterval { return self }

    public var seconds: TimeInterval { return self }

    public var minute: TimeInterval { return self * 60 }

    public var minutes: TimeInterval { return self * 60 }

    public var hour: TimeInterval { return self * 3600 }

    public var hours: TimeInterval { return self * 3600 }

    public var day: TimeInterval { return self * 3600 * 24 }

    public var days: TimeInterval { return self * 3600 * 24 }
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


// MARK: - Header / Footer
public extension UITableView {

    func hideAllCellSeparators() {

        separatorColor = UIColor.clear
    }


    // ???: Use this or tableviewcell method?
    func setSeparatorInsetLeft() {

        if responds(to: #selector(setter:self.separatorInset)) {
            separatorInset = .zero
        }
        if responds(to: #selector(setter:self.layoutMargins)) {
            layoutMargins = .zero
        }
        if responds(to: #selector(setter:self.cellLayoutMarginsFollowReadableWidth)) {
            cellLayoutMarginsFollowReadableWidth = false
        }
        for cell: UITableViewCell in visibleCells {
            if cell.responds(to: #selector(setter:self.separatorInset)) {
                cell.separatorInset = .zero
            }
            if cell.responds(to: #selector(setter:self.preservesSuperviewLayoutMargins)) {
                cell.preservesSuperviewLayoutMargins = false
            }
            if cell.responds(to: #selector(setter:self.layoutMargins)) {
                cell.layoutMargins = .zero
            }
        }
    }


    func blurSeperator() {

        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            self.backgroundView = blurEffectView

            //if you want translucent vibrant table view separator lines
            self.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        }
    }


    public func basicCleanup() {

        self.tableFooterView = UIView()
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }

}


extension UIView {
    // use self instead of passing view
    func insertBlurView(_ view: UIView, style: UIBlurEffectStyle) {

        view.backgroundColor = UIColor.clear

        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }

}


class CountedColor {
    let color: UIColor

    let count: Int


    init(color: UIColor, count: Int) {

        self.color = color
        self.count = count
    }
}


//extension UIImage {
//    
//    fileprivate func resize(_ newSize: CGSize) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 2)
//        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return result!
//    }
//    
//    public func colors(_ scaleDownSize: CGSize? = nil) -> (background: UIColor, primary: UIColor, secondary: UIColor, detail: UIColor) {
//        let cgImage: CGImage
//        
//        if let scaleDownSize = scaleDownSize {
//            cgImage = resize(scaleDownSize).cgImage!
//        } else {
//            let ratio = size.width / size.height
//            let r_width: CGFloat = 250
//            cgImage = resize(CGSize(width: r_width, height: r_width / ratio)).cgImage!
//        }
//        
//        let width = cgImage.width
//        let height = cgImage.height
//        let bytesPerPixel = 4
//        let bytesPerRow = width * bytesPerPixel
//        let bitsPerComponent = 8
//        let randomColorsThreshold = Int(CGFloat(height) * 0.01)
//        let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        let whiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let raw = malloc(bytesPerRow * height)
//        let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue
//        let context = CGContext(data: raw, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
//        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
//        let data = UnsafePointer<UInt8>(context?.data?.assumingMemoryBound(to: UInt8.self))
//        let imageBackgroundColors = NSCountedSet(capacity: height)
//        let imageColors = NSCountedSet(capacity: width * height)
//        
//        let sortComparator: (CountedColor, CountedColor) -> Bool = { (a, b) -> Bool in
//            return a.count <= b.count
//        }
//        
//        for x in 0..<width {
//            for y in 0..<height {
//                let pixel = ((width * y) + x) * bytesPerPixel
//                let color = UIColor(
//                    red:   CGFloat((data?[pixel+1])!) / 255,
//                    green: CGFloat((data?[pixel+2])!) / 255,
//                    blue:  CGFloat((data?[pixel+3])!) / 255,
//                    alpha: 1
//                )
//                
//                if x >= 5 && x <= 10 {
//                    imageBackgroundColors.add(color)
//                }
//                
//                imageColors.add(color)
//            }
//        }
//        
//        var sortedColors = [CountedColor]()
//        
//        for color in imageBackgroundColors {
//            guard let color = color as? UIColor else { continue }
//            
//            let colorCount = imageBackgroundColors.count(for: color)
//            
//            if randomColorsThreshold <= colorCount  {
//                sortedColors.append(CountedColor(color: color, count: colorCount))
//            }
//        }
//        
//        sortedColors.sort(by: sortComparator)
//        
//        var proposedEdgeColor = CountedColor(color: blackColor, count: 1)
//        
//        if let first = sortedColors.first { proposedEdgeColor = first }
//        
//        if proposedEdgeColor.color.isBlackOrWhite && !sortedColors.isEmpty {
//            for countedColor in sortedColors where CGFloat(countedColor.count / proposedEdgeColor.count) > 0.3 {
//                if !countedColor.color.isBlackOrWhite {
//                    proposedEdgeColor = countedColor
//                    break
//                }
//            }
//        }
//        
//        let imageBackgroundColor = proposedEdgeColor.color
//        let isDarkBackgound = imageBackgroundColor.isDark
//        
//        sortedColors.removeAll()
//        
//        for imageColor in imageColors {
//            guard let imageColor = imageColor as? UIColor else { continue }
//            
//            let color = imageColor.colorWithMinimumSaturation(minSaturation: 0.15)
//            
//            if color.isDark == !isDarkBackgound {
//                let colorCount = imageColors.count(for: color)
//                sortedColors.append(CountedColor(color: color, count: colorCount))
//            }
//        }
//        
//        sortedColors.sort(by: sortComparator)
//        
//        var primaryColor, secondaryColor, detailColor: UIColor?
//        
//        for countedColor in sortedColors {
//            let color = countedColor.color
//            
//            if primaryColor == nil &&
//                color.isContrastingWith(imageBackgroundColor) {
//                primaryColor = color
//            } else if secondaryColor == nil &&
//                primaryColor != nil &&
//                primaryColor!.isDistinctFrom(color) &&
//                color.isContrastingWith(imageBackgroundColor) {
//                secondaryColor = color
//            } else if secondaryColor != nil &&
//                (secondaryColor!.isDistinctFrom(color) &&
//                    primaryColor!.isDistinctFrom(color) &&
//                    color.isContrastingWith(imageBackgroundColor)) {
//                detailColor = color
//                break
//            }
//        }
//        
//        free(raw)
//        
//        return (
//            imageBackgroundColor,
//            primaryColor   ?? (isDarkBackgound ? whiteColor : blackColor),
//            secondaryColor ?? (isDarkBackgound ? whiteColor : blackColor),
//            detailColor    ?? (isDarkBackgound ? whiteColor : blackColor))
//    }
//    
//    public func color(at point: CGPoint) -> UIColor? {
//        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        guard let imgRef = cgImage,
//            let dataProvider = imgRef.dataProvider,
//            let dataCopy = dataProvider.data,
//            let data = CFDataGetBytePtr(dataCopy),
//            rect.contains(point) else {
//                return nil
//        }
//        
//        let pixelInfo = (Int(size.width) * Int(point.y) + Int(point.x)) * 4
//        let red = CGFloat(data[pixelInfo]) / 255.0
//        let green = CGFloat(data[pixelInfo + 1]) / 255.0
//        let blue = CGFloat(data[pixelInfo + 2]) / 255.0
//        let alpha = CGFloat(data[pixelInfo + 3]) / 255.0
//        
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//}
