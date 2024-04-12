import Foundation

final class HomeScene: Scene {

    init() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()

        viewController.viewModel = viewModel
        viewModel.viewController = viewController

        super.init(viewController: viewController, viewModel: viewModel)
    }
}
