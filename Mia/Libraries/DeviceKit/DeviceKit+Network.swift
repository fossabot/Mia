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

    /// Get the networkSSID . Doesn't work in the Simulator
    public static var ssidName: String {

        guard let interfaces = CNCopySupportedInterfaces() else { return "" }
        guard let interfacesArray = interfaces as? [String], interfacesArray.count > 0 else { return "" }
        guard let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfacesArray[0] as CFString) else { return "" }
        guard let interfaceData = unsafeInterfaceData as? [String: Any] else { return "" }
        return interfaceData["SSID"] as! String
    }

}
