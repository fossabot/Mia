// MARK: -
public struct FontKit {

    public typealias FontLoadedHandler = ([String]) -> Void
    private typealias FontPath = String
    private typealias FontName = String
    private typealias FontExtension = String
    private typealias FontTuple = (path: FontPath, name: FontName, ext: FontExtension)

    // MARK: *** Configuration ***
    public struct Configuration {

        /// Determines whether debug messages will be logged. Defaults to false.
        public static var debugMode = false
    }

    // MARK: *** Properties ***

    /// A list of loaded fonts.
    public static var loadedFonts: [String] = []

    // MARK: *** Public Methods ***

    /// Load all fonts found in a Mia.
    public static func loadMia() {

        let bundle = Bundle(for: MiaDummy.self)
        loadFontsInBundle(withPath: bundle.bundlePath)
        loadFontsFromBundlesFoundInBundle(path: bundle.bundlePath)
    }

    /// Load all fonts found in a specific bundle.
    ///
    /// - Parameters:
    ///   - bundle: The bundle to check. Defaults to `Bundle.main`
    ///   - handler: The callback with a [String] containing the loaded font's names.
    public static func load(bundle: Bundle = Bundle.main, completion handler: FontLoadedHandler? = nil) {

        loadFontsInBundle(withPath: bundle.bundlePath)
        loadFontsFromBundlesFoundInBundle(path: bundle.bundlePath)
        handler?(loadedFonts)
    }

    // MARK: *** Private Methods ***

    /// Loads all fonts found in a bundle.
    ///
    /// - Parameter path: The absolute path to the bundle.
    private static func loadFontsInBundle(withPath path: String) {

        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path) as [String]
            let loadedFonts = fonts(fromPath: path, withContents: contents)
            if !loadedFonts.isEmpty {
                for font in loadedFonts {
                    loadFont(font: font)
                }
            } else {
                FontKit.debug(message: "No fonts were found in the bundle path: \(path).")
            }
        } catch let error as NSError {
            FontKit.debug(message: "There was an error loading from the bundle.\nPath: \(path).\nError: \(error)")
        }
    }

    /// Loads all fonts found in a bundle that is loaded within another bundle.
    ///
    /// - Parameter path: The absolute path to the bundle.
    private static func loadFontsFromBundlesFoundInBundle(path: String) {

        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path)
            for item in contents {
                if let url = URL(string: path), item.contains(".bundle") {
                    let urlPathString = url.appendingPathComponent(item).absoluteString
                    loadFontsInBundle(withPath: urlPathString)
                }
            }
        } catch let error as NSError {
            FontKit.debug(message: "There was an error accessing the bundle. \nPath: \(path).\nError: \(error)")
        }
    }

    /// Loads a specific font.
    ///
    /// - Parameter font: The font to load.
    private static func loadFont(font: FontTuple) {

        let path: FontPath = font.path
        let name: FontName = font.name
        let ext: FontExtension = font.ext
        let url = URL(fileURLWithPath: path).appendingPathComponent(name).appendingPathExtension(ext)

        var fontError: Unmanaged<CFError>?

        guard let data = try? Data(contentsOf: url) as CFData, let dataProvider = CGDataProvider(data: data) else {
            guard let fontError = fontError?.takeRetainedValue() else {
                FontKit.debug(message: "Failed to load font '\(name)'.")
                return
            }

            let errorDescription = CFErrorCopyDescription(fontError)
            FontKit.debug(message: "Failed to load font '\(name)': \(String(describing: errorDescription))")
            return
        }

        /// Fixes deadlocking issue caused by `let fontRef = CGFont(dataProvider)`.
        /// Temporary fix until rdar://18778790 is addressed.
        /// Open Radar at http://www.openradar.me/18778790
        /// Discussion at https://github.com/ArtSabintsev/FontBlaster/issues/19
        _ = UIFont()

        let fontRef = CGFont(dataProvider)
        if CTFontManagerRegisterGraphicsFont(fontRef!, &fontError) {

            if let postScriptName = fontRef?.postScriptName {
                FontKit.debug(message: "Successfully loaded font: '\(postScriptName)'.")
                loadedFonts.append(String(postScriptName))
            }
        } else if let fontError = fontError?.takeRetainedValue() {
            let errorDescription = CFErrorCopyDescription(fontError)
            FontKit.debug(message: "Failed to load font '\(name)': \(String(describing: errorDescription))")
        }
    }

    /// Parses all of the fonts into their name and extension components.
    ///
    /// - Parameters:
    ///   - path: The absolute path to the font file.
    ///   - contents: The contents of an Bundle as an array of String objects.
    /// - Returns: An  array of `FontTuple` containing all fonts found at the specified path.
    private static func fonts(fromPath path: String, withContents contents: [String]) -> [FontTuple] {

        func splitComponents(fromName name: String) -> (FontName, FontExtension) {

            let components = name.characters.split { $0 == "." }.map { String($0) }
            return (components[0], components[1])
        }

        var fonts = [ FontTuple ]()
        for fontName in contents {
            var parsedFont: (FontName, FontExtension)?

            if fontName.contains(".ttf") || fontName.contains(".otf") {
                parsedFont = splitComponents(fromName: fontName)
            }

            if let parsedFont = parsedFont {
                let font: FontTuple = (path, parsedFont.0, parsedFont.1)
                fonts.append(font)
            }
        }

        return fonts
    }

    /// Prints debug messages to the console if debugEnabled is set to true.
    ///
    /// - Parameter message: The message to print to the console.
    static func debug(message: String) {

        Rosewood.Framework.print(framework: "FontKit", message: message, debugEnabled: Configuration.debugMode)
    }
}
