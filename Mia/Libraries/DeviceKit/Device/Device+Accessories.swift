import AVFoundation
import ExternalAccessory

// MARK: -
public extension Device.Accessories {

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
