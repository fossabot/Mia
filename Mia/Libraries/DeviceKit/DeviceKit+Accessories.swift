import AVFoundation
import ExternalAccessory
import UIKit

// TODO: [DeviceKit] check accessories availability by name (use enum?)

public extension DeviceKit.Accessories {

    /// The number of connected accessories
    public static var count: Int {

        return EAAccessoryManager.shared().connectedAccessories.count
    }

    /// The accessories connected and available to use for the app as EAAccessory objects
    public static var connectedAccessories: [EAAccessory] {

        return EAAccessoryManager.shared().connectedAccessories
    }

    /// The names of the attached accessories
    public static var connectedAccessoriesNames: [String] {

        var theNames: [String] = []
        for accessory in EAAccessoryManager.shared().connectedAccessories {
            theNames.append(accessory.name)
        }
        return theNames
    }

    /// Determines whether headphones are plugged in
    public static var isHeadsetPluggedIn: Bool {

        let route = AVAudioSession.sharedInstance().currentRoute
        return !route.outputs.filter({ $0.portType == AVAudioSessionPortHeadphones }).isEmpty
    }

}
