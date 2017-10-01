import SystemConfiguration.CaptiveNetwork

// MARK: -
public extension Device.Network {

    /// Determines whether the device is connected to the WiFi network
    public static var isConnected: Bool {

        return Reachability()?.connection != .none
    }

    /// Determines whether the device is connected to the WiFi network
    public static var isConnectedViaWiFi: Bool {

        return Reachability()?.connection == .wifi
    }

    /// Determines whether the device is connected to the cellular network
    public static var isConnectedViaCellular: Bool {

        return Reachability()?.connection == .cellular
    }

    /// Get the networkSSID . Doesn't work in the Simulator
    public static var ssidName: String {

        guard isConnectedViaWiFi,
              let interfaces = CNCopySupportedInterfaces(),
              let interfacesArray = interfaces as? [String], interfacesArray.count > 0,
              let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfacesArray[0] as CFString),
              let interfaceData = unsafeInterfaceData as? [String: Any],
              let ssid = interfaceData["SSID"] as? String
        else { return "" }

        return ssid
    }
}
