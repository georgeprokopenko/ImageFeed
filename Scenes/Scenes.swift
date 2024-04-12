import Foundation

extension Scene {
    static let home = HomeScene()
    static let photo: (FeedItem) -> PhotoScene = { .init(for: $0) }
}
