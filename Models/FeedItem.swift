import Foundation

struct FeedItem: Decodable {

    struct Resources: Decodable {
        let landscape: URL
        let large2x: URL
    }

    let id: Int
    let src: Resources
    let photographer: String
}
