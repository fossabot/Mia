import Foundation
import UIKit
import Mia


struct MiaTheme: Theme {
    var name: String = "theme"
    let mainTextColor: UIColor
    let mainBackgroundColor: UIColor
}


struct MiaThemes {

    let dayTheme = MiaTheme(name: "Day",
                            mainTextColor: UIColor(hex6Value: 0x3498db),
                            mainBackgroundColor: UIColor(hex6Value: 0xECF0F1))

    let nightTheme = MiaTheme(name: "Night",
                              mainTextColor: UIColor(hex6Value: 0x34495e),
                              mainBackgroundColor: UIColor(hex6Value: 0x6C7A89))

}

