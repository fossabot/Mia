import UIKit


public typealias RevealingSplashViewCompletion = () -> Void
public typealias RevealingSplashViewExecution = () -> Void


public enum SplashAnimation: String {

    case `default`
    case rotateOut
    case wobbleAndZoomOut
    case swingAndZoomOut
    case popAndZoomOut
    case squeezeAndZoomOut
    case heartBeat

}


public class RevealingSplashView: UIView {

    // MARK: Variables

    /// The type of animation to use. Defaults to the twitter animation.
    public var animationType: SplashAnimation = .default {
        didSet {
            if animationType == .heartBeat && duration > 3.0 {
                duration = 3.0
            }
        }
    }

    /// The duration of the animation, default to 1.5 seconds. In the case of heartBeat animation recommended value is 3.
    public var duration: Double = 1.5

    /// The delay to play the animation. Defaults to 0.5
    public var delay: Double = 0.5

    /// The boolean to use custom colors.
    public var useCustomIconColor: Bool = false {
        didSet {
            if (useCustomIconColor == true) {
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                }
            } else {
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
            }
        }
    }

    ///The icon color of the image. Defaults to white.
    public var iconColor: UIColor = UIColor.white {
        didSet {
            imageView?.tintColor = iconColor
        }
    }

    /// The repeat counter for heart beat animation, default to 1
    public var minimumBeats: Int = 1

    private var heartAttack: Bool = false

    private var iconInitialSize: CGSize = CGSize(width: 60, height: 60) {
        didSet {
            imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        }
    }

    private var iconImage: UIImage? {
        didSet {
            if let iconImage = self.iconImage {
                imageView?.image = iconImage
            }
        }

    }

    private var imageView: UIImageView?

    // MARK: Init/Deinit

    /// Default constructor of the class
    ///
    /// - Parameters:
    ///   - iconImage: The Icon image to show the animation
    ///   - iconInitialSize: The initial size of the icon image
    ///   - backgroundColor: The background color of the image, ideally this should match your Splash view.
    public init(iconImage: UIImage, iconInitialSize: CGSize, backgroundColor: UIColor) {

        //Sets the initial values of the image view and icon view
        self.imageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        //Inits the view to the size of the screen
        super.init(frame: (UIScreen.main.bounds))

        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        //Set the initial size and position
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        //Sets the content mode and set it to be centered
        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        imageView?.center = self.center

        //Adds the icon to the view
        self.addSubview(imageView!)

        //Sets the background color
        self.backgroundColor = backgroundColor

    }


    public required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    // MARK:  Public Methods

    /// Starts the animation.
    ///
    /// - Parameter completion: The callback block.
    public func startAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        switch animationType {
            case .default:
                playTwitterAnimation(completion)

            case .rotateOut:
                playRotateOutAnimation(completion)

            case .wobbleAndZoomOut:
                playWobbleAnimation(completion)

            case .swingAndZoomOut:
                playSwingAnimation(completion)

            case .popAndZoomOut:
                playPopAnimation(completion)

            case .squeezeAndZoomOut:
                playSqueezeAnimation(completion)

            case .heartBeat:
                playHeartBeatAnimation(completion)
        }

    }


    // MARK: Private Methods

    private func playTwitterAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            //Define the shrink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.3

            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                imageView.transform = scaleTransform

                //When animation completes, grow the image
            }, completion: { finished in

                self.playZoomOutAnimation(completion)
            })
        }
    }


    private func playSqueezeAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.5

            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay / 3, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: UIView.AnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.30, y: 0.30)
                imageView.transform = scaleTransform

                //When animation completes, grow the image
            }, completion: { finished in

                self.playZoomOutAnimation(completion)
            })
        }
    }


    private func playRotateOutAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            /**
            Sets the animation with duration delay and completion

            - returns:
            */
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: UIView.AnimationOptions(), animations: {

                //Sets a simple rotate
                let rotateTranform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.99))
                //Mix the rotation with the zoom out animation
                imageView.transform = rotateTranform.concatenating(self.getZoomOutTransform())
                //Removes the animation
                self.alpha = 0

            }, completion: { finished in

                self.removeFromSuperview()

                completion?()
            })

        }
    }


    private func playWobbleAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            let woobleForce = 0.5

            animateLayer({
                             let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
                             rotation.values = [ 0, 0.3 * woobleForce, -0.3 * woobleForce, 0.3 * woobleForce, 0 ]
                             rotation.keyTimes = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ]
                             rotation.isAdditive = true

                             let positionX = CAKeyframeAnimation(keyPath: "position.x")
                             positionX.values = [ 0, 30 * woobleForce, -30 * woobleForce, 30 * woobleForce, 0 ]
                             positionX.keyTimes = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ]
                positionX.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                             positionX.isAdditive = true

                             let animationGroup = CAAnimationGroup()
                             animationGroup.animations = [ rotation, positionX ]
                             animationGroup.duration = CFTimeInterval(self.duration / 2)
                             animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay / 2)
                             animationGroup.repeatCount = 2
                             imageView.layer.add(animationGroup, forKey: "wobble")
                         }, completion: {

                self.playZoomOutAnimation(completion)
            })

        }
    }


    private func playSwingAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            let swingForce = 0.8

            animateLayer({
                             let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
                             animation.values = [ 0, 0.3 * swingForce, -0.3 * swingForce, 0.3 * swingForce, 0 ]
                             animation.keyTimes = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ]
                             animation.duration = CFTimeInterval(self.duration / 2)
                             animation.isAdditive = true
                             animation.repeatCount = 2
                             animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay / 3)
                             imageView.layer.add(animation, forKey: "swing")

                         }, completion: {
                self.playZoomOutAnimation(completion)
            })
        }
    }


    private func playPopAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            let popForce = 0.5

            animateLayer({
                             let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                             animation.values = [ 0, 0.2 * popForce, -0.2 * popForce, 0.2 * popForce, 0 ]
                             animation.keyTimes = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ]
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                             animation.duration = CFTimeInterval(self.duration / 2)
                             animation.isAdditive = true
                             animation.repeatCount = 2
                             animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay / 2)
                             imageView.layer.add(animation, forKey: "pop")
                         }, completion: {
                self.playZoomOutAnimation(completion)
            })
        }
    }


    private func playZoomOutAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = imageView {
            let growDuration: TimeInterval = duration * 0.3

            UIView.animate(withDuration: growDuration, animations: {

                imageView.transform = self.getZoomOutTransform()
                self.alpha = 0

                //When animation completes remote self from super view
            }, completion: { finished in

                self.removeFromSuperview()

                completion?()
            })
        }
    }


    private func playHeartBeatAnimation(_ completion: RevealingSplashViewCompletion? = nil) {

        if let imageView = self.imageView {

            let popForce = 0.8

            animateLayer({
                             let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                             animation.values = [ 0, 0.1 * popForce, 0.015 * popForce, 0.2 * popForce, 0 ]
                             animation.keyTimes = [ 0, 0.25, 0.35, 0.55, 1 ]
                             //animation.timingFunction = CAMediaTimingFunction.easeInEaseOut //  CAMediaTimingFunction(name: .easeInEaseOut)
                             animation.duration = CFTimeInterval(self.duration / 2)
                             animation.isAdditive = true
                             animation.repeatCount = Float(minimumBeats > 0 ? minimumBeats : 1)
                             animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay / 2)
                             imageView.layer.add(animation, forKey: "pop")
                         }, completion: { [weak self] in
                if self?.heartAttack ?? true {
                    self?.playZoomOutAnimation(completion)
                } else {
                    self?.playHeartBeatAnimation(completion)
                }
            })
        }
    }


    /// End the heartbeat animation. Does nothing unless animationType is 'heartBeat'.
    public func finishHeartBeatAnimation() {

        self.heartAttack = true
    }


    // MARK: Helpers

    private func getZoomOutTransform() -> CGAffineTransform {

        let zoomOutTransform: CGAffineTransform = CGAffineTransform(scaleX: 20, y: 20)
        return zoomOutTransform
    }


    private func animateLayer(_ animation: RevealingSplashViewExecution, completion: RevealingSplashViewCompletion? = nil) {

        CATransaction.begin()
        if let completion = completion {
            CATransaction.setCompletionBlock { completion() }
        }
        animation()
        CATransaction.commit()
    }
}

