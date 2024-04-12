import Foundation
import Moya

protocol NetworkServiceProtocol {

    func loadPhotos(page: Int) async -> FeedResponse?
}

class NetworkService: NetworkServiceProtocol {

    private lazy var networkProvider = MoyaProvider<ImageFeedAPI>(
        plugins: [AuthPlugin(key: Constants.apiKey)]
    )

    func loadPhotos(page: Int) async -> FeedResponse? {
        await request(target: .photos(page: page))
    }

    // MARK: Private

    private func request<T: Decodable>(target: ImageFeedAPI) async -> T? {
        let result: APIResult<T> = await networkProvider.makeRequest(target)

        switch result {
        case let .success(data):
            return data
        case .failure:
            return nil
        }
    }
}

extension MoyaProvider {

    func makeRequest<T: TargetType, R: Decodable>(_ target: T) async -> APIResult<R> {
        do {
            guard let target = target as? Target else {
                return .failure(.unknown)
            }

            let response = try await requestWithPossibleError(target)

            #if DEBUG
            if let dataDict = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                print("Response: \(response)")

                for (key, value) in dataDict {
                    print("\(key): \(value)")
                }
            }
            #endif

            if let data = try? response.map(R.self) {
                return .success(data)
            } else {
                return .failure(.unknown)
            }

        } catch {
            return .failure(.unknown)
        }
    }

    private func requestWithPossibleError(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
