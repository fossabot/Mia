import UIKit

public struct RobotoFont: FontType {
    
    public enum FontType {
        
        
        
        
    }
//    /// Size of font.
//    public static var pointSize: CGFloat {
//        return Font.pointSize
//    }
//
//    /// Thin font.
//    public static var thin: UIFont {
//        return thin(with: Font.pointSize)
//    }
//
//    /// Light font.
//    public static var light: UIFont {
//        return light(with: Font.pointSize)
//    }
//
//    /// Regular font.
//    public static var regular: UIFont {
//        return regular(with: Font.pointSize)
//    }
//
//    /// Medium font.
//    public static var medium: UIFont {
//        return medium(with: Font.pointSize)
//    }
//
//    /// Bold font.
//    public static var bold: UIFont {
//        return bold(with: Font.pointSize)
//    }
    
    public struct Regular {
        
        public static func black(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Black")
            if let f = UIFont(name: "Roboto-Black", size: size) {
                return f
            }
            return Font.systemFont(ofSize: size)
        }
        
        
        public static func blackItalic(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-BlackItalic")
            if let f = UIFont(name: "Roboto-BlackItalic", size: size) {
                return f
            }
            return Font.systemFont(ofSize: size)
        }
        
        public static func bold(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Bold")
            if let f = UIFont(name: "Roboto-Bold", size: size) {
                return f
            }
            return Font.systemFont(ofSize: size)
        }
        
        
        public static func boldItalic(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-BoldItalic")
            if let f = UIFont(name: "Roboto-ThinItalic", size: size) {
                return f
            }
            return Font.systemFont(ofSize: size)
        }
        
        public static func italic(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Italic")
            if let f = UIFont(name: "Roboto-Italic", size: size) {
                return f
            }
            return Font.systemFont(ofSize: size)
        }
        
        public static func light(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Light")
            
            if let f = UIFont(name: "Roboto-Light", size: size) {
                return f
            }
            
            return Font.systemFont(ofSize: size)
        }
        
        public static func lightItalic(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-LightItalic")
            
            if let f = UIFont(name: "Roboto-LightItalic", size: size) {
                return f
            }
            
            return Font.systemFont(ofSize: size)
        }
        
        
        public static func medium(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Medium")
            
            if let f = UIFont(name: "Roboto-Medium", size: size) {
                return f
            }
            
            return Font.boldSystemFont(ofSize: size)
        }
        
        public static func mediumItalic(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-MediumItalic")
            
            if let f = UIFont(name: "Roboto-MediumItalic", size: size) {
                return f
            }
            
            return Font.boldSystemFont(ofSize: size)
        }
        
        public static func regular(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Regular")
            
            if let f = UIFont(name: "Roboto-Regular", size: size) {
                return f
            }
            
            return Font.systemFont(ofSize: size)
        }
        
        public static func thin(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-Thin")
            
            if let f = UIFont(name: "Roboto-Thin", size: size) {
                return f
            }
            
            return Font.systemFont(ofSize: size)
        }
        
        public static func thinItalic(with size: CGFloat) -> UIFont {
            Font.loadFontIfNeeded(name: "Roboto-ThinItalic")
            
            if let f = UIFont(name: "Roboto-ThinItalic", size: size) {
                return f
            }
            
            return Font.systemFont(ofSize: size)
        }
        
        

    }
    
    
}

