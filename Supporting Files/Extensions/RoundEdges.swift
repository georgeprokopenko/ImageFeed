import UIKit
import Foundation

struct RoundEdges: OptionSet {

    static let topEdge = RoundEdges(rawValue: 1 << 0)
    static let bottomEdge = RoundEdges(rawValue: 1 << 1)
    static let rightTop = RoundEdges(rawValue: 1 << 2)
    static let trailingEdge = RoundEdges(rawValue: 1 << 3)
    
    static let empty: RoundEdges = []
    static let all: RoundEdges = [.topEdge, .bottomEdge]

    let rawValue: Int

    init(rawValue: Int) {
        self.rawValue = rawValue
    }

    var maskedCorners: CACornerMask {
        var corners: CACornerMask = []
        if contains(.topEdge) {
            corners.formUnion([.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }

        if contains(.bottomEdge) {
            corners.formUnion([.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }

        if contains(.rightTop) {
            corners.formUnion([.layerMaxXMinYCorner])
        }

        return corners
    }
}
