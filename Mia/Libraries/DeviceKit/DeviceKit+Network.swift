import Alamofire
import SystemConfiguration.CaptiveNetwork
import UIKit

public extension DeviceKit.Network {

    /// Determines whether the device is connected to the WiFi network
    public static var isConnected: Bool {

        return isConnectedViaWiFi || isConnectedViaCellular
    }

    /// Determines whether the device is connected to the WiFi network
    public static var isConnectedViaWiFi: Bool {

        return NetworkReachabilityManager()!.isReachableOnEthernetOrWiFi
    }

    /// Determines whether the device is connected to the cellular network
    public static var isConnectedViaCellular: Bool {

        return NetworkReachabilityManager()!.isReachableOnWWAN
    }

    // TODO: Pick a ssid method from below.

    /// Get the network SSID (doesn't work in the Simulator). Empty string if not available
    public static var SSID: String {

        // Doesn't work in the Simulator
        var currentSSID = ""
        if let interfaces: CFArray = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces) {
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    for dictData in interfaceData! {
                        if dictData.key as! String == "SSID" {
                            currentSSID = dictData.value as! String
                        }
                    }
                }
            }
        }

        return currentSSID
    }

    /// Returns the name of the network the device is currently connected to.
    public static var networkSSID: String {

        let interfaces = CNCopySupportedInterfaces()
        if interfaces == nil {
            return ""
        }

        let interfacesArray = interfaces as! [String]
        if interfacesArray.count <= 0 {
            return ""
        }

        let interfaceName = interfacesArray[0] as String
        let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName as CFString)
        if unsafeInterfaceData == nil {
            return ""
        }

        let interfaceData = unsafeInterfaceData as! Dictionary<String, AnyObject>

        return interfaceData["SSID"] as! String
    }

}
