// FontKit.Loader was inspired by https://github.com/ArtSabintsev/FontBlaster
// FontRepresentable was inspired by https://github.com/Nirma/UIFontComplete

// MARK: -
public struct FontKit {

    /// FontKit configurations.
    public struct Configuration {

        /// Toggles debug print statements. Defaults to false.
        public static var debugMode = false

        /// Scale factor for iPads. Defaults to 2.0.
        public static var iPadScaleFactor: Float = 2.0
    }

    /// Prints debug messages to the console if debugEnabled is set to true.
    ///
    /// - Parameter message: The status to print to the console.
    static func debug(message: String) {

        Rosewood.Framework.print(framework: "FontKit", message: message, debugEnabled: Configuration.debugMode)
    }
}
