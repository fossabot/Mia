// MARK: -
extension Application {

    public enum Bundle: String {

        case name = "CFBundleName"
        case displayName = "CFBundleDisplayName"
        case identifier = "CFBundleIdentifier"
        case version = "CFBundleShortVersionString"
        case build = "CFBundleVersion"
        case executable = "CFBundleExecutable"

        
        /// Returns the app's product name if display name is not set.
        public static var dynamicName: String {

            let displayName = Bundle.displayName.description
            return displayName.isEmpty ? Bundle.name.description : displayName
        }
    }
}

// MARK: -
extension Application.Bundle: CustomStringConvertible {

    public var description: String {
        return Foundation.Bundle.main.infoDictionary?[self.rawValue] as? String ?? ""
    }
}
