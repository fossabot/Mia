import SystemConfiguration.CaptiveNetwork

// MARK: - *** Device ***
public struct Device {

    public struct Accessories {
    }

    public struct Carrier {
    }

    public struct Disk {
    }

    public struct Firmware {
    }

    public struct Processors {
    }

    public struct Screen {
    }

    public struct Sensors {
    }

    public struct Settings {
    }
}

// MARK: - *** Battery ***
extension Device {

    public struct Battery {

        /// Determines whether the low power mode is currently enabled
        @available(iOS 9.0, *)
        public static var isLowPowerModeEnabled: Bool {

            return ProcessInfo().isLowPowerModeEnabled
        }

        /// The battery's current level
        public static var level: Int {

            UIDevice.current.isBatteryMonitoringEnabled = true
            let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
            UIDevice.current.isBatteryMonitoringEnabled = false

            return batteryLevel
        }

        /// The battery's current
        public static var state: UIDeviceBatteryState {

            UIDevice.current.isBatteryMonitoringEnabled = true
            let batteryState = UIDevice.current.batteryState
            UIDevice.current.isBatteryMonitoringEnabled = false

            return batteryState
        }
    }
}

// MARK: - *** Network ***
extension Device {

    public struct Network {

        /// Determines whether the device is connected to the WiFi network
        @available(*, deprecated, message: "Doesnt seem to work.")
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
}


// MARK: - *** Screen ***
extension Device {
    
    public struct Screens {
        
        
        
    }
}
