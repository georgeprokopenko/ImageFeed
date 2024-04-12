import UIKit

class AuthorView: ViewWithLayout {

    private enum Appearance {
        static let verticalInset: CGFloat = 8
        static let horizontalInset: CGFloat = 16
        static let font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    private lazy var padding = UIView(
        backgroundColor: Palette.interfaceBlack.inverted.color,
        cornerRadius: 10,
        clipsToBounds: true,
        maskedCorners: RoundEdges.all.maskedCorners
    )

    private lazy var label = UILabel(
        font: Appearance.font,
        textColor: Palette.interfaceBlack.color
    )

    override func loadLayout() {
        addSubviews(padding, label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        padding.pin.all()
        label.pin
            .vCenter()
            .horizontally(16)
            .sizeToFit()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let textSize = model.text.size(with: Appearance.font)
        return .init(
            width: textSize.width + Appearance.horizontalInset * 2,
            height: textSize.height + Appearance.verticalInset * 2
        )
    }

    // MARK: - Model

    private var model = Model(text: "")

    struct Model {
        let text: String
    }

    func setModel(_ model: Model) {
        self.model = model
        label.text = model.text

        setNeedsLayout()
    }
}
