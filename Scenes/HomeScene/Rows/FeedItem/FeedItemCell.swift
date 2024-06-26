import EasyCollectionView
import Foundation
import UIKit

protocol FeedItemCellViewModelProtocol: CommonRowViewModelProtocol {

    func didReceiveTap()
}

final class FeedItemCell: CommonRowCell {

    // MARK: - Layout

    private lazy var button = IFButton()
        .withShadow()
        .withAction { [unowned self] _ in
            viewModel?.didReceiveTap()
        }

    private lazy var imageView = UIImageView(
        backgroundColor: .white.withAlphaComponent(0.3),
        cornerRadius: 26,
        clipsToBounds: true,
        maskedCorners: RoundEdges.all.maskedCorners
    )

    private lazy var authorView = AuthorView()

    override func loadLayout() {
        addSubview(button)
        button.addSubviews(imageView)
        imageView.addSubviews(authorView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        button.pin
            .horizontally(16)
            .vertically(8)

        imageView.pin.all()

        authorView.pin
            .bottomLeft()
            .sizeToFit()
    }

    static func height(with width: CGFloat, model: Model) -> CGFloat {
        200
    }

    // MARK: - DarkMode Support

    func updateStyle() {
        imageView.alpha = traitCollection.userInterfaceStyle == .light ? 1.0 : 0.7
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateStyle()
    }

    // MARK: - Model

    struct Model {
        let author: String
        let imageResource: URL
    }

    weak var viewModel: FeedItemCellViewModelProtocol?

    func setModel(_ model: Model) {
        imageView.loadImage(for: model.imageResource)
        authorView.setModel(.init(text: model.author))

        updateStyle()
        setNeedsLayout()
    }

    func dispose() {
        imageView.cancelLoadingImage()
    }
}
