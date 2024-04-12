import UIKit

class ShadowButton: UIButton {

    struct Settings {
        let color: UIColor
        let offset: CGSize
        let opacity: Float
        let shadowRadius: CGFloat

        static let `default` = Settings(
            color:  .black,
            offset: .init(width: 0, height: 0),
            opacity: 0.7,
            shadowRadius: 20
        )
    }

    private var shadowView: ShadowView?

    private func setShadow(_ settings: Settings) {
        shadowView?.removeFromSuperview()

        let shadowView = ShadowView()
        shadowView.shadowColor = settings.color
        shadowView.shadowOffset = settings.offset
        shadowView.shadowOpacity = settings.opacity
        shadowView.shadowRadius = settings.shadowRadius
        shadowView.isUserInteractionEnabled = false

        shadowView.clipsToBounds = false

        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shadowView?.pin.all()
    }

    // MARK: - Public accessor

    func withShadow(_ settings: Settings = .default) -> Self {
        setShadow(settings)
        setNeedsLayout()

        return self
    }
}
