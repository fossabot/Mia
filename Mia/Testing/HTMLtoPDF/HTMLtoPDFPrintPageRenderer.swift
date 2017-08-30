
class HTMLtoPDFPrintPageRenderer: UIPrintPageRenderer {

    var topBottomMarginSize: CGFloat
    var leftRightMarginSize: CGFloat

    override var paperRect: CGRect {
        return UIGraphicsGetPDFContextBounds()
    }

    override var printableRect: CGRect {
        return paperRect.insetBy(dx: self.leftRightMarginSize, dy: self.topBottomMarginSize)
    }

    public init(_ topBottomSize: CGFloat, _ leftRightSize: CGFloat) {

        self.topBottomMarginSize = topBottomSize
        self.leftRightMarginSize = leftRightSize
    }

}
