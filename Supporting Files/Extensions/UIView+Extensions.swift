import UIKit

extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview)
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}

extension UIView {

    convenience init(backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0, clipsToBounds: Bool? = nil, maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], tintColor: UIColor? = nil, borderWidth: CGFloat = 0, isUserInteractionEnabled: Bool? = nil) {
        self.init()

        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }

        if let clipsToBounds = clipsToBounds {
            self.clipsToBounds = clipsToBounds
        }

        if let tintColor = tintColor {
            self.tintColor = tintColor
        }

        if let isUserInteractionEnabled = isUserInteractionEnabled {
            self.isUserInteractionEnabled = isUserInteractionEnabled
        }

        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        layer.borderWidth = borderWidth
    }
}
