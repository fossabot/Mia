import UIKit


public extension UIColor {

    public class func color(fromValue: Double, _ useDarkColors: Bool = true) -> UIColor {

        if useDarkColors {
            return (fromValue < 0) ? UIColor.red : UIColor.white
        } else {
            return (fromValue < 0) ? UIColor.red : UIColor.black
        }

    }

}
