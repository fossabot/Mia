import UIKit


class CollectionViewStackCell: UICollectionViewCell {

    // MARK: Init/Deinit

    override init(frame: CGRect) {

        super.init(frame: frame)
        imageView = createImageView()
        createShadow()
    }


    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Variables

    internal var imageView: UIImageView?


    // MARK: Private Methods

    internal override func prepareForReuse() {

        imageView?.image = nil
    }


    fileprivate func createImageView() -> UIImageView {

        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shouldRasterize = true
        contentView.addSubview(imageView)

        contentView.addConstraints([ createConstraint(imageView, toItem: contentView, attribute: .top),
                                     createConstraint(imageView, toItem: contentView, attribute: .bottom),
                                     createConstraint(imageView, toItem: contentView, attribute: .left),
                                     createConstraint(imageView, toItem: contentView, attribute: .right) ])

        return imageView
    }


    fileprivate func createConstraint(_ item: UIImageView, toItem: UIView, attribute: NSLayoutAttribute) -> NSLayoutConstraint {

        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: attribute, multiplier: 1, constant: 0)
    }


    fileprivate func createShadow() {

        layer.masksToBounds = false;
        layer.shadowOpacity = 0.30;
        layer.shadowRadius = 10.0;
        layer.shadowOffset = CGSize.zero;
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true;
        layer.rasterizationScale = max(UIScreen.main.scale, 2.0)
    }


    fileprivate func addBlurOnImage(_ image: UIImageView) {

        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        imageView!.insertSubview(blurView, at: 3)

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)

    }

}
