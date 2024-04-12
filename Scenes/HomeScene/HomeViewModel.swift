import Foundation

protocol HomeViewModelProtocol: BaseViewModelProtocol {

    func viewDidLoad()
    func viewDidRefresh()
    func willDisplayCell(at idx: Int)
}

final class HomeViewModel {

    private lazy var mainRouter = Services.shared.mainRouter
    private lazy var feedService = Services.shared.feedService

    weak var viewController: HomeViewControllerProtocol?
    private var didLoadOnce = false

    private lazy var feedItemRow: (FeedItem) -> FeedItemCellViewModelProtocol = {
        FeedItemCellViewModel(
            model: .init(
                item: $0,
                tapHandler: { [item = $0, unowned self] in
                    didTapItem(item)
                }
            )
        )
    }

    func reloadData() {
        load(mode: .refresh)
    }

    private func load(mode: FeedLoadingMode) {
        Task {
            try await displayItems(
                feedService.load(mode: mode)
            )
        }
    }

    @MainActor
    private func displayItems(_ items: [FeedItem]) {
        viewController?.reloadCollectionView(
            with: items.map { feedItemRow($0) },
            animated: didLoadOnce
        )

        didLoadOnce = true
    }

    private func didTapItem(_ item: FeedItem) {
        mainRouter.present(.photo(item))
    }
}

// MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {

    func viewDidLoad() {
        reloadData()
    }

    func willDisplayCell(at idx: Int) {
        if idx + Constants.feedNextPageCountTreshold == feedService.loadedItemsCount {
            load(mode: .nextPage)
        }
    }

    func viewDidRefresh() {
        reloadData()
    }
}
