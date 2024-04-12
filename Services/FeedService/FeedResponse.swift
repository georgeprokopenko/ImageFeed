import Foundation

struct FeedResponse: Decodable {
    var page: Int
    var photos: [FeedItem]

    static let empty = FeedResponse(page: 1, photos: [])
}
