import Foundation

extension Sequence {

    func mapToDict<T: Hashable, U>(transform: (Element) throws -> (T, U)) rethrows -> [T: U] {
        var result: [T: U] = [:]
        for value in self {
            let (transformedKey, transformedValue) = try transform(value)
            result[transformedKey] = transformedValue
        }
        return result
    }
}

extension Array {

    subscript(safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

extension Collection {

    var nonEmpty: Self? {
        isEmpty ? nil : self
    }
}
