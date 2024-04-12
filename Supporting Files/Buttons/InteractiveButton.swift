import UIKit

class InteractiveButton: ShadowButton {

    var isShrinkable = true
    var isHapticsEnabled = true

    private var _isEnabled = true
    private var settings: (wasShrinkable: Bool, wasHapticsEnabled: Bool) = (true, true)

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard isShrinkable else {
            return
        }

        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard isShrinkable else {
            return
        }

        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }

        if isHapticsEnabled {
            Impacter.impact(intensity: 1)
        }
    }
}
