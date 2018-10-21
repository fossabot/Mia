import UIKit


//fileprivate func <<T:Comparable>(lhs: T?, rhs: T?) -> Bool {
//
//    switch (lhs, rhs) {
//        case let (l?, r?):
//            return l < r
//        case (nil, _?):
//            return true
//        default:
//            return false
//    }
//}


// MARK: - CollectionStackViewControllerDelegate

protocol CollectionStackViewControllerDelegate: class {
    func controllerDidSelected(index: Int)
}


// MARK: - CollectionStackViewController

class CollectionStackViewController: UICollectionViewController {

    // MARK: Delegate

    weak var delegate: CollectionStackViewControllerDelegate?


    // MARK: Init/Deinit

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    init(images: [UIImage], delegate: CollectionStackViewControllerDelegate?, overlay: Float, scaleRatio: Float, scaleValue: Float, bgColor: UIColor = UIColor.clear, bgView: UIView? = nil, decelerationRate: CGFloat) {

        self.screens = images
        self.delegate = delegate
        self.overlay = overlay

        let layout = CollectionViewStackFlowLayout(itemsCount: images.count, overlay: overlay, scaleRatio: scaleRatio, scale: scaleValue)
        super.init(collectionViewLayout: layout)

        if let collectionView = self.collectionView {
            collectionView.backgroundColor = bgColor
            collectionView.backgroundView = bgView
            collectionView.decelerationRate = decelerationRate
        }
    }


    // MARK: Variables

    fileprivate var screens: [UIImage]

    fileprivate let overlay: Float


    // MARK: Public Methods

    override func viewDidLoad() {

        configureCollectionView()
        scrollToIndex(screens.count - 1, animated: false, position: .left) // move to end
    }


    override func viewDidAppear(_ animated: Bool) {

        guard let collectionViewLayout = self.collectionViewLayout as? CollectionViewStackFlowLayout else {
            fatalError("wrong collection layout")
        }

        collectionViewLayout.openAnimating = true
        scrollToIndex(0, animated: true, position: .left) // open animation
    }


    // MARK: Private Methods

    fileprivate func configureCollectionView() {

        guard let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("wrong collection layout")
        }

        collectionViewLayout.scrollDirection = .horizontal
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(CollectionViewStackCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewStackCell.self))
    }


    // MARK: Helpers

    fileprivate func scrollToIndex(_ index: Int, animated: Bool, position: UICollectionViewScrollPosition) {

        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: position, animated: animated)
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension CollectionStackViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return screens.count
    }


    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let cell = cell as? CollectionViewStackCell {
            cell.imageView?.image = screens[(indexPath as NSIndexPath).row]
        }
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewStackCell.self),
                                                      for: indexPath)
        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let currentCell = collectionView.cellForItem(at: indexPath) else {
            return
        }

        // move cells
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn,
                       animations: { () -> Void in
                           for cell in self.collectionView!.visibleCells where cell != currentCell {
                               let row = (self.collectionView?.indexPath(for: cell) as NSIndexPath?)?.row
                            let xPosition = row! < (indexPath as NSIndexPath).row ? cell.center.x - self.view.bounds.size.width * 2
                                       : cell.center.x + self.view.bounds.size.width * 2

                               cell.center = CGPoint(x: xPosition, y: cell.center.y)
                           }
                       }, completion: nil)

        // move to center current cell
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut,
                       animations: { () -> Void in
                           let offset = collectionView.contentOffset.x - (self.view.bounds.size.width - collectionView.bounds.size.width * CGFloat(self.overlay)) * CGFloat((indexPath as NSIndexPath).row)
                           currentCell.center = CGPoint(x: (currentCell.center.x + offset), y: currentCell.center.y)
                       }, completion: nil)

        // scale current cell
        UIView.animate(withDuration: 0.2, delay: 0.6, options: .curveEaseOut, animations: { () -> Void in
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            currentCell.transform = scale
            currentCell.alpha = 1

        }) { (success) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                self.delegate?.controllerDidSelected(index: (indexPath as NSIndexPath).row)
                self.dismiss(animated: false, completion: nil)
            })
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionStackViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return view.bounds.size
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: NSInteger) -> CGFloat {

        return -collectionView.bounds.size.width * CGFloat(overlay)
    }
}
