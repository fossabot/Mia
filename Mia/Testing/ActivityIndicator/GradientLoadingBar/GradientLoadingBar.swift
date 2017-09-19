import UIKit


// Handler for GradientView
public class GradientLoadingBar {

    // Instance variable for singleton
    public static var shared: GradientLoadingBar = GradientLoadingBar()


    public struct DefaultValues {

        public static let height = 20.0

        public static let durations = Durations(fadeIn: 0.33, fadeOut: 0.33, progress: 3.33)

        //        public static let gradientColors: GradientColors = [
        //            UIColor(hexString: "#4cd964").cgColor,
        //            UIColor(hexString: "#5ac8fa").cgColor,
        //            UIColor(hexString: "#007aff").cgColor,
        //            UIColor(hexString: "#34aadc").cgColor,
        //            UIColor(hexString: "#5856d6").cgColor,
        //            UIColor(hexString: "#ff2d55").cgColor
        //        ]

        public static let gradientGreenColors: GradientColors = [
            UIColor(hexString: "#14C3A2").cgColor,
            UIColor(hexString: "#0DE5A8").cgColor,
            UIColor(hexString: "#7CF49A").cgColor,
            UIColor(hexString: "#B8FD99").cgColor
        ]
    }


    // View contain the gradient bar
    private let gradientView: GradientView

    // Used to add "gradientView" once to key window on first call of "show()"
    private var addedToKeyWindow = false

    // Used to handle mutliple calls to show at the same time
    private var isVisible = false

    // Height of gradient bar
    private var height = 0.0


    // MARK: - Initializers

    public init(height: Double = DefaultValues.height, durations: Durations = DefaultValues.durations, gradientColors: GradientColors = DefaultValues.gradientGreenColors) {

        self.height = height

        gradientView = GradientView(
                durations: durations,
                gradientColors: gradientColors
        )
    }


    deinit {

        if addedToKeyWindow {
            gradientView.removeFromSuperview()
        }
    }


    // MARK: - Layout

    private func addGradientViewToKeyWindow() {

        guard let keyWindow = UIApplication.shared.keyWindow else {
            print("GradientLoadingBar: Couldn't add gradientView to keyWindow, as it is not available yet. Aborting.")
            return
        }

        // Add gradient view to main window
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        keyWindow.addSubview(gradientView)

        // Layout gradient view in main window
        setupConstraints(keyWindow: keyWindow)
    }


    private func setupConstraints(keyWindow: UIWindow) {

        gradientView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor).isActive = true

        gradientView.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }


    // MARK: - Helper to use as a Singleton

    public func saveInstance() {

        type(of: self).shared = self
    }


    // MARK: - Show / Hide

    public func show() {

        if !addedToKeyWindow {
            addedToKeyWindow = true

            addGradientViewToKeyWindow()
        }

        if !isVisible {
            isVisible = true

            gradientView.show()
        }
    }


    public func hide() {

        if isVisible {
            isVisible = false

            gradientView.hide()
        }
    }


    public func toggle() {

        if isVisible {
            hide()
        } else {
            show()
        }
    }
}
