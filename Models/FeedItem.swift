import Foundation

struct FeedItem: Decodable {

    struct Resources: Decodable {
        let landscape: URL
        let original: URL
    }

    let id: Int
    let src: Resources
    let photographer: String
}
