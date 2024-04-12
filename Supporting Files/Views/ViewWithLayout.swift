import Foundation
import UIKit

class ViewWithLayout: AutoStyledView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        _loadLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        _loadLayout()
    }

    private var didLoadLayout: Bool = false

    private func _loadLayout() {
        guard !didLoadLayout else {
            return
        }

        loadLayout()
        setNeedsLayout()

        didLoadLayout = true
    }

    func loadLayout() {
        fatalError("Override me")
    }
}

class AutoStyledView: UIView {

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }

        didChangeInterfaceStyle(to: traitCollection.userInterfaceStyle)
    }

    func didChangeInterfaceStyle(to style:  UIUserInterfaceStyle) {}
}
