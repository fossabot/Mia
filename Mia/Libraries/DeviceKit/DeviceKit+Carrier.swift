import CoreTelephony
import UIKit

public extension DeviceKit.Carrier {

    /// The name of the carrier or nil if not available
    public static var name: String? {

        return CTTelephonyNetworkInfo().subscriberCellularProvider?.carrierName
    }

    /// The carrier ISO code or nil if not available
    public static var ISOCountryCode: String? {

        return CTTelephonyNetworkInfo().subscriberCellularProvider?.isoCountryCode
    }

    /// The carrier mobile country code or nil if not available
    public static var mobileCountryCode: String? {

        return CTTelephonyNetworkInfo().subscriberCellularProvider?.mobileCountryCode
    }

    /// The carrier network country code or nil if not available
    public static var mobileNetworkCode: String? {

        return CTTelephonyNetworkInfo().subscriberCellularProvider?.mobileNetworkCode
    }

    /// Determines whether the carrier allows VOIP
    public static var allowsVOIP: Bool? {

        return CTTelephonyNetworkInfo().subscriberCellularProvider?.allowsVOIP
    }

}
