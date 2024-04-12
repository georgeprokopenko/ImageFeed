import Foundation

protocol FeedServiceProtocol {

    var loadedItemsCount: Int { get }
    func load(mode: FeedLoadingMode) async throws -> [FeedItem]
}

enum FeedLoadingMode {
    case refresh
    case nextPage
}

class FeedService: FeedServiceProtocol {

    private lazy var provider = Services.shared.networkService
    private var data: FeedResponse = .empty

    var loadedItemsCount: Int {
        data.photos.count
    }

    func load(mode: FeedLoadingMode) async throws -> [FeedItem] {
        if mode == .refresh {
            data = .empty
        }

        guard let result = await provider.loadPhotos(page: data.page) else {
            throw IFError.unknown
        }

        switch mode {
        case .refresh:
            data = result
        case .nextPage:
            data.photos.append(contentsOf: result.photos)
        }

        data.page += 1
        return data.photos
    }
}
