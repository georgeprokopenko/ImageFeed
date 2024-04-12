import Foundation

final class Services {
    static let shared = Services()

    lazy var mainRouter: MainRouterProtocol = MainRouter()
    lazy var feedService: FeedServiceProtocol = FeedService()
    lazy var imageService: ImageServiceProtocol = ImageService()
    lazy var networkService: NetworkServiceProtocol = NetworkService()
}
