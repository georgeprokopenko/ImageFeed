import Foundation

struct FeedResponse: Decodable {
    var page: Int
    var photos: [FeedItem]

    static var empty: FeedResponse {
        .init(page: initialPage, photos: [])
    }

    private static var initialPage: Int {
        Int.random(in: 1...20)
    }
}
