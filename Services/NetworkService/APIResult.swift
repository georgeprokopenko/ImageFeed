import Foundation

enum APIResult<R> {
    case success(R)
    case failure(IFError)
}
