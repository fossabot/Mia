import UIKit


public typealias GradientColors = [CGColor]

private let fadeInAnimationKey = "GradientView--fade-in"
private let fadeOutAnimationKey = "GradientView--fade-out"
private let progressAnimationKey = "GradientView--progress"


final class GradientView: UIView {

    fileprivate let gradientLayer = CAGradientLayer()

    fileprivate let durations: Durations

    fileprivate let gradientColors: GradientColors


    // MARK: - Initializers

    init(durations: Durations, gradientColors: GradientColors) {

        self.durations = durations
        self.gradientColors = gradientColors

        super.init(frame: .zero)

        setupGradientLayer()
    }


    required public init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Setup "CAGradientLayer"

    private func setupGradientLayer() {

        gradientLayer.opacity = 0.0

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        // Simulate infinte animation
        var reversedColors = Array(gradientColors.reversed())
        reversedColors.removeFirst() // Remove first and last item to prevent duplicate values
        reversedColors.removeLast()  // destroying infinite animation.

        gradientLayer.colors =
        gradientColors + reversedColors + gradientColors

        // Add layer to view
        layer.insertSublayer(gradientLayer, at: 0)
    }


    // MARK: - Layout

    override func layoutSubviews() {

        super.layoutSubviews()

        // Three times of the width in order to apply normal, reversed and normal gradient to simulate infinte animation
        gradientLayer.frame =
        CGRect(x: 0, y: 0, width: 3 * bounds.size.width, height: bounds.size.height)

        // Update width
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
    }


    // MARK: Fade-In / Out animations

    private func toggleGradientLayerVisibility(duration: TimeInterval, start: CGFloat, end: CGFloat, key: String) {

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.delegate = self

        animation.fromValue = start
        animation.toValue = end

        animation.duration = duration

        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        gradientLayer.add(animation, forKey: key)
    }


    // MARK: - Public trigger methods

    func show() {

        gradientLayer.removeAnimation(forKey: fadeOutAnimationKey)
        toggleGradientLayerVisibility(duration: durations.fadeIn, start: 0.0, end: 1.0, key: fadeInAnimationKey)
    }


    func hide() {

        gradientLayer.removeAnimation(forKey: fadeInAnimationKey)
        toggleGradientLayerVisibility(duration: durations.fadeOut, start: 1.0, end: 0.0, key: fadeOutAnimationKey)
    }
}


extension GradientView: CAAnimationDelegate {

    func animationDidStart(_ anim: CAAnimation) {

        if anim == gradientLayer.animation(forKey: fadeInAnimationKey) {
            // Start progress animation
            let animation = CABasicAnimation(keyPath: "position")

            animation.fromValue = CGPoint(x: -2 * bounds.size.width, y: 0)
            animation.toValue = CGPoint(x: 0, y: 0)

            animation.duration = durations.progress
            animation.repeatCount = Float.infinity

            gradientLayer.add(animation, forKey: progressAnimationKey)
        }
    }


    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

        if anim == gradientLayer.animation(forKey: fadeOutAnimationKey) {
            // Stop progress animation
            gradientLayer.removeAnimation(forKey: progressAnimationKey)
        }
    }

}
