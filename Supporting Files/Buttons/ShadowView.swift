import UIKit

class ShadowView: UIView {

    var roundingCorners: UIRectCorner = .allCorners {
        didSet {
            guard roundingCorners != oldValue else {
                return
            }

            update()
        }
    }

    var needsShowShadow: Bool = true {
        didSet {
            guard needsShowShadow != oldValue else {
                return
            }

            update()
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat = 8 {
        didSet {
            guard cornerRadius != oldValue else {
                return
            }

            update()
        }
    }

    var shadowColor: UIColor = UIColor.black {
        didSet {
            guard shadowColor != oldValue else {
                return
            }

            update()
        }
    }

    @IBInspectable
    var shadowOpacity: Float = 0.36 {
        didSet {
            guard shadowOpacity != oldValue else {
                return
            }

            update()
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat = 2.0 {
        didSet {
            guard shadowRadius != oldValue else {
                return
            }

            update()
        }
    }

    var shadowInsets: UIEdgeInsets = .zero {
        didSet {
            guard shadowInsets != oldValue else {
                return
            }

            update()
        }
    }

    var shadowEdges: UIRectEdge = .all {
        didSet {
            guard shadowEdges != oldValue else {
                return
            }

            update()
        }
    }

    @IBInspectable
    var shadowOffset: CGSize = .zero {
        didSet {
            guard shadowOffset != oldValue else {
                return
            }

            update()
        }
    }

    override var bounds: CGRect {
        didSet {
            if !bounds.size.equalTo(oldValue.size) {
                update()
            }
        }
    }

    override var frame: CGRect {
        didSet {
            if !frame.size.equalTo(oldValue.size) {
                update()
            }
        }
    }

    var rasterizationEnabled: Bool = true {
        didSet {
            guard rasterizationEnabled != oldValue else {
                return
            }

            update()
        }
    }

    private var maskLayer: CAShapeLayer!

    private func update() {
        if backgroundColor != .clear {
            backgroundColor = .clear
        }

        if needsShowShadow {
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowColor = shadowColor.cgColor
            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = rasterizationEnabled

            let rect = bounds.inset(by: shadowInsets)
            layer.shadowPath = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: roundingCorners,
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            ).cgPath
        } else {
            layer.shadowOpacity = 0
        }
        if needsShowShadow && shadowEdges != .all {
            let clipPath = UIBezierPath(rect: clippingRect())

            if maskLayer == nil {
                maskLayer = CAShapeLayer()
            }
            maskLayer.path = clipPath.cgPath
            layer.mask = maskLayer
        } else {
            layer.mask = nil
        }
    }

    private func clippingRect() -> CGRect {
        var clipRect = bounds.inset(by: shadowInsets)
        let shadowMargin = shadowRadius * 2
        if shadowEdges.contains(.left) {
            clipRect.origin.x -= shadowMargin
            clipRect.size.width += shadowMargin
        }
        if shadowEdges.contains(.top) {
            clipRect.origin.y -= shadowMargin
            clipRect.size.height += shadowMargin
        }
        if shadowEdges.contains(.right) {
            clipRect.size.width += shadowMargin
        }
        if shadowEdges.contains(.bottom) {
            clipRect.size.height += shadowMargin
        }

        return clipRect
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        update()
    }
}
