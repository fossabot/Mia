import UIKit


public class BlurredBackgroundView: UIView {

    public var blurView: UIVisualEffectView

    public var imageView: UIImageView? {
        didSet {
            self.insertSubview(imageView!, at: 0)
        }
    }


    public init(style: UIBlurEffectStyle, image: UIImage?) {

        let blurEffect = UIBlurEffect(style: style)
        blurView = UIVisualEffectView(effect: blurEffect)

        super.init(frame: .zero)

        if let image = image {
            imageView = UIImageView(image: image)
        }

        addSubview(blurView)

    }


    public init(frame: CGRect, style: UIBlurEffectStyle, image: UIImage?) {

        let blurEffect = UIBlurEffect(style: style)
        blurView = UIVisualEffectView(effect: blurEffect)

        super.init(frame: frame)

        if let image = image {
            imageView = UIImageView(image: image)
        }

        addSubview(blurView)

    }


    public convenience required init?(coder aDecoder: NSCoder) {

        self.init(coder: aDecoder)
    }


    public override func layoutSubviews() {

        super.layoutSubviews()
        imageView?.frame = bounds
        blurView.frame = bounds
    }
}
