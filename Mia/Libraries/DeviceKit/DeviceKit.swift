import AVFoundation
import CoreMotion
import CoreTelephony
import ExternalAccessory
import Foundation
import SystemConfiguration.CaptiveNetwork
import UIKit

// http://www.everyi.com/

public struct DeviceKit {

    /// A UUID that may be used to uniquely identify the device, same across apps from a single vendor.
    public static var identifierForVendor: UUID? {
        return UIDevice.current.identifierForVendor!
    }

    public struct Accessories {
    }

    public struct Application {
    }

    public struct Battery {
    }

    public struct Carrier {
    }

    public struct Device {
    }

    public struct Disk {
    }

    public struct Firmware {
    }

    public struct Network {
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

