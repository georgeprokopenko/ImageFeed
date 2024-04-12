import Foundation
import Moya

enum ImageFeedAPI {
    case photos(page: Int)
}

extension ImageFeedAPI: TargetType {

    var baseURL: URL {
        .init(string: Constants.apiUrl)!
    }

    var path: String {
        switch self {
        case .photos:
            "/curated"
        }
    }

    var method: Moya.Method {
        switch self {
        case .photos:
            .get
        }
    }

    var task: Task {
        switch self {
        case .photos(let page):
                .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
}

struct AuthPlugin: PluginType {
    let key: String

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue(key, forHTTPHeaderField: "Authorization")
        return request
    }
}
