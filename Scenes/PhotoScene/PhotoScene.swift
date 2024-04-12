import Foundation

final class PhotoScene: Scene {

    init(for feedItem: FeedItem) {
        let viewController = PhotoViewController()
        let viewModel = PhotoViewModel(item: feedItem)

        viewController.viewModel = viewModel
        viewModel.viewController = viewController

        super.init(viewController: viewController, viewModel: viewModel)
    }
}
