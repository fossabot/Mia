import UIKit


class CollectionViewStackFlowLayout: UICollectionViewFlowLayout {

    // MARK: Init/Deinit

    init(itemsCount: Int, overlay: Float, scaleRatio: Float, scale: Float) {

        self.itemsCount = itemsCount
        self.overlay = overlay
        self.scaleRatio = scaleRatio
        self.maxScale = scale
        super.init()
    }


    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Variables

    let itemsCount: Int

    let overlay: Float // from 0 to 1

    let maxScale: Float

    let scaleRatio: Float

    var additionScale = 1.0

    var openAnimating = false

    var dxOffset: Float = 0


    // MARK: Private Methods

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        let items = NSArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        var headerAttributes: UICollectionViewLayoutAttributes?

        items.enumerateObjects({ (object, idex, stop) -> Void in
            let attributes = object as! UICollectionViewLayoutAttributes

            if attributes.representedElementKind == UICollectionElementKindSectionHeader {
                headerAttributes = attributes
            } else {
                self.updateCellAttributes(attributes, headerAttributes: headerAttributes)
            }
        })
        return items as? [UICollectionViewLayoutAttributes]
    }


    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {

        return true
    }


    // MARK: Helpers

    func updateCellAttributes(_ attributes: UICollectionViewLayoutAttributes, headerAttributes: UICollectionViewLayoutAttributes?) {

        guard let collectionView = self.collectionView else {
            return;
        }
        let itemWidth = collectionView.bounds.size.width - collectionView.bounds.size.width * CGFloat(overlay)
        let allWidth = itemWidth * CGFloat(itemsCount - 1)

        // set contentOffset range
        let contentOffsetX = min(max(0, collectionView.contentOffset.x), allWidth)

        let scale = transformScale(attributes, allWidth: allWidth, offset: contentOffsetX)
        let move = transformMove(attributes, itemWidth: itemWidth, offset: contentOffsetX)
        attributes.transform = scale.concatenating(move)
        attributes.alpha = calculateAlpha(attributes, itemWidth: itemWidth, offset: contentOffsetX)

        if additionScale > 0 && openAnimating {
            additionScale -= 0.02
            additionScale = additionScale < 0 ? 0 : additionScale
        }
        attributes.zIndex = (attributes.indexPath as NSIndexPath).row
    }


    fileprivate func transformScale(_ attributes: UICollectionViewLayoutAttributes, allWidth: CGFloat, offset: CGFloat) -> CGAffineTransform {

        var maximum = CGFloat(maxScale) - CGFloat(itemsCount - (attributes.indexPath as NSIndexPath).row) / CGFloat(scaleRatio)
        maximum += CGFloat(1.0 - maximum) * CGFloat(additionScale)

        var minimum = CGFloat(maxScale - 0.1) - CGFloat(itemsCount - (attributes.indexPath as NSIndexPath).row) / CGFloat(scaleRatio)
        minimum += CGFloat(1.0 - minimum) * CGFloat(additionScale)

        var currentScale = (maximum + minimum) - (minimum + offset / (allWidth / (maximum - minimum)))
        currentScale = max(min(maximum, currentScale), minimum)
        return CGAffineTransform(scaleX: currentScale, y: currentScale)
    }


    fileprivate func transformMove(_ attributes: UICollectionViewLayoutAttributes, itemWidth: CGFloat, offset: CGFloat) -> CGAffineTransform {

        var currentContentOffsetX = offset - itemWidth * CGFloat((attributes.indexPath as NSIndexPath).row)
        currentContentOffsetX = min(max(currentContentOffsetX, 0), itemWidth)

        var dx = (currentContentOffsetX / itemWidth)
        if let collectionView = self.collectionView {
            dx *= collectionView.bounds.size.width / 8.0
        }
        dx = currentContentOffsetX - dx

        return CGAffineTransform(translationX: dx, y: 0)
    }


    fileprivate func calculateAlpha(_ attributes: UICollectionViewLayoutAttributes, itemWidth: CGFloat, offset: CGFloat) -> CGFloat {

        var currentContentOffsetX = offset - itemWidth * CGFloat((attributes.indexPath as NSIndexPath).row)
        currentContentOffsetX = min(max(currentContentOffsetX, 0), itemWidth)

        let dx = (currentContentOffsetX / itemWidth)

        return 1.0 - dx
    }

}