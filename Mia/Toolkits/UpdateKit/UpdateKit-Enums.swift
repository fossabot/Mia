public typealias CheckBlock = () -> ()

public enum UpdateType {

    /// Allow the user to ignore updates.
    case normal

    /// Force the user to update.
    case force
}

public enum LastRunType {

    // The app has not changed.
    case noChanges

    /// The app is a fresh install.
    case freshInstall

    /// The app has been updated.
    case updated

    /// The app has been downgraded.
    case downgraded

    /// I cannot think of any reason this would be called.
    case unknown
}

public class AppStore_Apps_Version: Codable {
    
    var Id: Int
    var AppId: Int
    var vMajor: Int
    var vMinor: Int
    var vPatch: Int
    var PList_URL: String
    var ReleaseDate: Date
    
    var versionString: String {
        return "\(vMajor).\(vMinor).\(vPatch)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case Id, AppId
        case vMajor, vMinor, vPatch
        case PList_URL
        case ReleaseDate
    }
}
