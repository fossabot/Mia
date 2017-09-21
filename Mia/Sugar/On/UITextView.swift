import UIKit

public extension Container where Host: UITextView {

    func textChange(_ action: @escaping StringAction) {

        let target = TextViewTarget(host: host, action: action)
        self.textViewTarget = target
    }
}

class TextViewTarget: NSObject, UITextViewDelegate {
    var action: StringAction?

    init(host: UITextView, action: @escaping StringAction) {

        super.init()

        self.action = action
        host.delegate = self
    }

    // MARK: - UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {

        action?(textView.text ?? "")
    }
}
