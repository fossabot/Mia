public final class BlurredBackgroundView: UIView {

    public final var imageView: UIImageView? = nil
    public final var blurView: UIVisualEffectView
    public final var separatorEffect: UIVibrancyEffect
    
    
    public init(style: UIBlurEffect.Style, image: UIImage? = nil) {

        let blurEffect = UIBlurEffect(style: style)
        blurView = UIVisualEffectView(effect: blurEffect)
        separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        if let image = image { imageView = UIImageView(image: image) }

        super.init(frame: .zero)

        if let imageView = imageView { addSubview(imageView) }
        addSubview(blurView)
    }

    public required init?(coder aDecoder: NSCoder) {

        let blurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)

        super.init(coder: aDecoder)

        if let imageView = imageView {
            addSubview(imageView)
        }
        addSubview(blurView)
    }

    public override func layoutSubviews() {

        super.layoutSubviews()
        if let imageView = imageView {
            imageView.frame = bounds
        }
        blurView.frame = bounds
    }
}


