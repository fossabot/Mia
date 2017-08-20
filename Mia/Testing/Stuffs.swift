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

}
