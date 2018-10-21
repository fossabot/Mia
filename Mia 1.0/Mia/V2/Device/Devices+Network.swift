import SystemConfiguration.CaptiveNetwork


extension Devices.Network {
    
    private static var connection: Reachability.Connection = Reachability()!.connection
    
    
    /// Determines whether the device is connected to the WiFi network
    public static var isConnected: Bool {
        
        return connection != .none
    }
    
    /// Determines whether the device is connected to the WiFi network
    public static var isConnectedViaWiFi: Bool {
        
        return connection == .wifi
    }
    
    /// Determines whether the device is connected to the cellular network
    public static var isConnectedViaCellular: Bool {
        
        return connection == .cellular
    }
    
    /// Get the name of the network the device is currently connected to. Does not work on Simulator.
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
