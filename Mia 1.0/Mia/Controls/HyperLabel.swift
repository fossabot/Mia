import UIKit


public protocol HyperLabelInteractionDelegate: class {
    func didSelectLink(sender: HyperLabel, url: URL)
}


public class HyperLabel: UILabel {

    @IBInspectable var hyperlinkColour: UIColor = UIColor(red: 64 / 255, green: 120 / 255, blue: 192 / 255, alpha: 1.0)

    open weak var interactionDelegate: HyperLabelInteractionDelegate?

    public var linkAttributeDefault = [ NSAttributedString.Key: Any ]()
    public var urls = [ URL ]()
    fileprivate var ranges = [ NSMutableDictionary ]()

    override init(frame: CGRect) {

        super.init(frame: frame)
        self.setupDefault()
    }

    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        self.setupDefault()
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let value = NSValue()
            if let urlID = value.attributedTextRangeForPointInLabel(point: touch.location(in: self), label: self) {
                if (self.urls.count > urlID) {
                    let url = self.urls[urlID]

                    if (UIApplication.shared.canOpenURL(url)) {
                        UIApplication.shared.openURL(url)
                        interactionDelegate?.didSelectLink(sender: self, url: url)
                    }
                }
            }

        }
    }

    private func setupDefault() {

        self.isUserInteractionEnabled = true

        self.linkAttributeDefault = [ NSAttributedString.Key.foregroundColor: hyperlinkColour,
                                      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]
    }

    public func setLinkFor(substring: String, url: URL, attributes: [NSAttributedString.Key: Any]? = nil) {

        urls.append(url)

        let currentText = NSString(string: self.text!)
        let substringRange = currentText.range(of: substring)
        if (substringRange.length > 0) {
            self.setLinkFor(range: substringRange, attributes: attributes ?? self.linkAttributeDefault)
        }
    }

    private func setLinkFor(range: NSRange, attributes: [NSAttributedString.Key: Any]) {

        let mutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        if (attributes.count > 0) {
            mutableAttributedString.addAttributes(attributes, range: range)
        }

        let dictToAdd = NSMutableDictionary()
        dictToAdd["url_index"] = urls.count - 1
        dictToAdd["range"] = range

        self.ranges.append(dictToAdd)

        self.attributedText = mutableAttributedString
    }

}


extension NSValue {
    func attributedTextRangeForPointInLabel(point: CGPoint, label: HyperLabel) -> Int? {

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)

        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = 0
        textContainer.size = label.bounds.size

        layoutManager.addTextContainer(textContainer)

        // Text storage to calculate the position
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        textStorage.addLayoutManager(layoutManager)

        // Find the tapped character location and compare it to the specified range
        let locationInLabel = point
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (label.bounds.width - textBoundingBox.width) * 0.5 - textBoundingBox.minX,
                                          y: (label.bounds.height - textBoundingBox.width) * 0.5 - textBoundingBox.minY)

        let locationOfTouchInTextContainer = CGPoint(x: locationInLabel.x - textContainerOffset.x,
                                                     y: locationInLabel.y - textContainerOffset.y)

        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                            in: textContainer,
                                                            fractionOfDistanceBetweenInsertionPoints: nil)

        for dict in label.ranges {
            let range = dict.object(forKey: "range") as! NSRange
            if (NSLocationInRange(indexOfCharacter, range)) {
                return dict["url_index"] as? Int;
            }
        }

        return nil
    }
}
