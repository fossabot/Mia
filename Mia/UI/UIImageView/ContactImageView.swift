//
//  ContactImageView
//  ContactImageView
//
//  Created by George on 2016-05-29.
//  Copyright © 2016 George Kye. All rights reserved.
//

import UIKit


@IBDesignable
open class ContactImageView: UIImageView {

    
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    
    public enum Display {
        case fullName, initials
    }


    public enum Shape {
        case square, circle
    }


    // MARK: - *** IBInspectable Properties ***

    // MARK: Font

    /// Sets font for text (Default is UIFont(20) **UIFONT not currently supported in @IBInspectable
    public var font: UIFont = UIFont.systemFont(ofSize: 20)

    @IBInspectable
    public var fontName: String? {
        didSet {
            if let fontName = fontName, let setFont = UIFont(name: fontName, size: fontSize) {
                    font = setFont
                    setImageText()
                }
            
        }
    }

    @IBInspectable
    public var fontSize: CGFloat = 22 {
        didSet {
            font = font.withSize(fontSize)
            setImageText()
        }
    }

    // MARK: Text

    /// Set text to be displayed in UIImageView, default is "GK".
    @IBInspectable
    public var text: String = "GK" {
        didSet {
            setImageText()
        }
    }

    /// Sets color of text being displayed, default is white color
    @IBInspectable
    public var textColor: UIColor = UIColor.white {
        didSet {
            setImageText()
        }
    }

    // Adapter
    public var textDisplay: Display = .initials {
        didSet {
            setImageText()
        }
    }

    @IBInspectable
    public var backgroundImage: UIImage? = nil {
        didSet {
            setImageText()
        }
    }

    /// Returns a circular if set true, default is false
    public var shape: Shape = .circle {
        didSet {
            switch shape {
                case .square: self.layer.cornerRadius = 0
                case .circle: self.layer.cornerRadius = self.bounds.width / 2
            }

        }
    }

    /// Set background color your imageview
    @IBInspectable
    public var fillColor: UIColor? {
        didSet {
            setImageText()
        }
    }

    override open var bounds: CGRect {
        didSet {
            setImageText()
        }
    }

    
    

    public func setImageText() {

        let imgText = getCharactersFromName(text: text)

        let attributes = getAttributedText(text: imgText, color: textColor, textFont: font)
        let attributedText = NSAttributedString(string: imgText, attributes: attributes)
        self.image = createImage(attributedString: attributedText, backgroundImage: backgroundImage, backgroundColor: fillColor ?? UIColor(seed: text))
    }

    //MARK: Private funcs

    /**
     Returns an NSAttribute based on the color and font, size is determined by the number of characters in text
     - parameter text:     size is determined by number of characters
     - parameter color:    color for NSForegroundColorAttribute
     - parameter textFont: font for NSFontAttribute

     - returns: [String: AnyObject] to be used as an NSAttribute
     */

    func getAttributedText(text: String, color: UIColor, textFont: UIFont) -> [NSAttributedStringKey: AnyObject] {

        let area: CGFloat = self.bounds.width * textFont.pointSize
        let size = sqrt(area / CGFloat(text.count))
        let attribute: [NSAttributedStringKey: AnyObject] = [ NSAttributedStringKey.foregroundColor: color,
                                                              NSAttributedStringKey.font: textFont.withSize(size) ]
        return attribute
    }

    /**
     Renders the text into the ImageView

     - parameter attributedString: attributes for the text to be rendered
     - parameter backgroundColor:  background color for UIImageVIew

     - returns: an ImageView with text rendered
     */
    private func createImage(attributedString: NSAttributedString, backgroundImage: UIImage? = nil, backgroundColor: UIColor) -> UIImage? {

        let scale = UIScreen.main.scale
        let bounds = self.bounds

        UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
        let context = UIGraphicsGetCurrentContext()

        switch shape {

            case .circle:
                let path = CGPath(ellipseIn: self.bounds, transform: nil);
                context?.addPath(path)
                context?.clip()

            default: break
        }

        if backgroundImage != nil {
            backgroundImage?.draw(in: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))

        } else {
            context?.setFillColor(backgroundColor.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        }

        let textSize = attributedString.size()
        let rect = CGRect(x: bounds.size.width / 2 - textSize.width / 2,
                          y: bounds.size.height / 2 - textSize.height / 2,
                          width: textSize.width,
                          height: textSize.height)

        attributedString.draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image;
    }

    /**
     Retrive initals from a full name

     - parameter text: full name

     - returns: returns a two character string (first inital and last inital
     */
    func getCharactersFromName(text: String) -> String {

        switch textDisplay {

            case .fullName: return text

            case .initials:

                var initial = String()
                let username = text.components(separatedBy: .whitespaces)

                if let initalFirst = username.first, !initalFirst.isEmpty, let firstChar = initalFirst.first {
                    initial.append(firstChar)
                }

                if let initalSecond = username.last, !initalSecond.isEmpty, username.first != username.last, let secondChar = initalSecond.first {
                    initial.append(secondChar)
                }
                
                return initial

        }

    }
}
