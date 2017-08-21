import Foundation
import UIKit


public func getTopMostController() -> UIViewController? {

    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    return nil
}


public extension UIView {

    //https://stackoverflow.com/questions/32151637/swift-get-all-subviews-of-a-specific-type-and-add-to-an-array

    /** This is the function to get subViews of a view of a particular type
     */
    /// <#Description#>
    ///
    /// - Parameter type: <#type description#>
    /// - Returns: <#return value description#>
    public func subViews<T:UIView>(type: T.Type) -> [T] {

        var all = [ T ]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }

    /** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
    /// <#Description#>
    ///
    /// - Parameter type: <#type description#>
    /// - Returns: <#return value description#>
    public func allSubViewsOf<T:UIView>(type: T.Type) -> [T] {

        var all = [ T ]()

        func getSubview(view: UIView) {

            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }

        getSubview(view: self)
        return all
    }
}


public enum SectionViewType {
    case button, label
}


// MARK: - Header / Footer
public extension UITableView {

    func hideAllCellSeparators() {

        separatorColor = UIColor.clear
    }

    func hideUnnecessaryCellSeparators() {

        let view = UIView()
        view.backgroundColor = UIColor.clear
        tableFooterView = view
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

    func viewForSection(_ label: String, _ target: Any, _ action: Selector, _ useDarkColors: Bool = true) -> UIView? {

        let viewHeader = self.viewForSection(label, useDarkColors)

        let button = UIButton(frame: viewHeader.frame)
        button.addTarget(target, action: action, for: .touchUpInside)
        viewHeader.addSubview(button)

        return viewHeader
    }

    func viewForSection(_ label: String, _ useDarkColors: Bool = true) -> UIView {

        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 30))
        viewHeader.autoresizingMask = [ .flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin ]

        let backgroundColor = (useDarkColors) ? UIColor.black : UIColor.white
        let textColor = (useDarkColors) ? UIColor.white : UIColor.black

        let viewLabel = UILabel(frame: viewHeader.frame)

        viewLabel.text = "   \(label)"
        viewLabel.backgroundColor = backgroundColor
        viewLabel.textColor = textColor;

        viewLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        viewLabel.textAlignment = .left

        viewHeader.addSubview(viewLabel)

        return viewHeader
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




public extension UIColor { // testing
    
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        //print(String(describing: hex3).characters.count, String(describing: hex3.description))
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex4: UInt16) {
        //print(String(describing: hex4).characters.count, String(describing: hex4.description))
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        //print(String(describing: hex6).characters.count, String(describing: hex6.description))
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex8: UInt32) {
        //print(String(describing: hex8).characters.count, String(describing: hex8.description))
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
