import EasyCollectionView
import UIKit

final class FeedItemCellViewModel {

    struct Model {
        let item: FeedItem
        let tapHandler: () -> Void
    }

    private lazy var imageService = Services.shared.imageService
    private weak var cell: FeedItemCell?
    private var cachedSize: CGSize?
    private var model: Model

    private lazy var cellModel: FeedItemCell.Model = .init(
        author: model.item.photographer,
        imageResource: model.item.src.landscape
    )

    init(model: Model) {
        self.model = model
    }

    private func bind(_ cell: FeedItemCell) {
        unbind()
        (cell.viewModel as? FeedItemCellViewModel)?.unbind()

        cell.viewModel = self
        self.cell = cell
    }

    private func unbind() {
        cell?.viewModel = nil
        cell = nil
    }
}

extension FeedItemCellViewModel: FeedItemCellViewModelProtocol {

    func didReceiveTap() {
        model.tapHandler()
    }
}

extension FeedItemCellViewModel: CommonRowViewModelProtocol {

    var rowId: String {
        "FeedItemCellViewModel-\(UUID().uuidString)"
    }

    var cellClass: AnyClass {
        FeedItemCell.self
    }

    func configure(_ cell: Any) {
        guard let cell = cell as? FeedItemCell else {
            return
        }

        bind(cell)
        cell.setModel(cellModel)
    }

    func height(with width: CGFloat) -> CGFloat {
        if let cachedSize = cachedSize, cachedSize.width == width {
            return cachedSize.height
        }

        let height = FeedItemCell.height(with: width, model: cellModel)
        cachedSize = CGSize(width: width, height: height)

        return height
    }

    func didHide(cell: Any) {
        (cell as? FeedItemCell)?.dispose()
    }
}
