//
//  FontStyles.swift
//  Mia
//
//  Created by Michael Hedaitulla on 10/4/17.
//

import UIKit

class FontStyles: NSObject {
}

public final class ScaledFont {

    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }

    private typealias StyleDictionary = [UIFontTextStyle.RawValue: FontDescription]
    private var styleDictionary: StyleDictionary?

    /// Create a `ScaledFont`
    ///
    /// - Parameter fontName: Name of a plist file (without the extension)
    ///   in the main bundle that contains the style dictionary used to
    ///   scale fonts for each text style.

    public init(fontName: String) {

        if let url = Bundle.main.url(forResource: fontName, withExtension: "plist"), let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(StyleDictionary.self, from: data)
        }
    }

    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `UIFontTextStyle` for the
    ///   font.
    /// - Returns: A `UIFont` of the custom font that has been
    ///   scaled for the users currently selected preferred
    ///   text size.
    ///
    /// - Note: If the style dictionary does not have
    ///   a font for this text style the default preferred
    ///   font is returned.

    public func font(forTextStyle textStyle: UIFontTextStyle) -> UIFont {

        if #available(iOS 11.0, *) {

            guard let fontDescription = styleDictionary?[textStyle.rawValue], let font = UIFont(name: fontDescription.fontName, size: Scale.fontSize(size: fontDescription.fontSize)) else {
                return UIFont.preferredFont(forTextStyle: textStyle)
            }

            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            return fontMetrics.scaledFont(for: font)
        } else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }
    }
}

struct Scale {

    static func cell(size: CGFloat) -> CGFloat {

        return Device.Screen.size(small: size, medium: size * 1.25, big: size * 1.5)
    }

    static func fontSize(size: CGFloat) -> CGFloat {

        return Device.Screen.size(small: size, medium: size * 1.2, big: size * 1.4)
    }
}

/// Work with sizes
public extension Device.Screen {

    /// Returns size for a specific device (iPad or iPhone/iPod)
    public static func size<T>(phone: T, pad: T) -> T {

        return (Device.isPad ? pad : phone)
    }

    /// Return size depending on specific screen family.
    /// If Screen size is unknown (in this case ScreenFamily will be unknown too) it will return small value
    ///
    /// `old` screen family is optional and if not defined will return `small` value
    ///
    /// - seealso: Screen, ScreenFamily
    public static func size<T>(old: T? = nil, small: T, medium: T, big: T) -> T {

        let family = Device.Screen.family

        switch family {
            case .old: return old ?? small
            case .small: return small
            case .medium: return medium
            case .big: return big
            default: return small
        }
    }

    /// Return value for specific screen size. Incoming parameter should be a screen size. If it is not defined
    /// nearest value will be used. Code example:
    ///
    /// ```
    /// let sizes: [Screen:AnyObject] = [
    ///     .inches_3_5: 12,
    ///     .inches_4_0: 13,
    ///     .inches_4_7: 14,
    ///     .inches_9_7: 15
    ///    ]
    /// let exactSize = Device.size(sizes: sizes) as! Int
    /// let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
    /// ```
    ///
    /// After that your font will be:
    /// * 12 for 3.5" inches (older devices)
    /// * 13 for iPhone 5, 5S
    /// * 14 for iPhone 6, 6Plus and iPad mini
    /// * and 15 for other iPads
    ///
    /// - seealso: Screen
    public static func size<T>(sizes: [ScreenSize: T]) -> T {

        let screen = Device.Screen.size
        var nearestValue: T?
        var distance = CGFloat.greatestFiniteMagnitude

        for (key, value) in sizes {
            // Prevent from iterating whole array
            if key == screen {
                return value
            }

            let actualDistance = fabs(key.rawValue - screen.rawValue)
            if actualDistance < distance {
                nearestValue = value
                distance = actualDistance
            }
        }

        return nearestValue!
    }
}
