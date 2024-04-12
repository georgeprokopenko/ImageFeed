import UIKit
import EasyCollectionView

protocol BaseViewModelProtocol {}

protocol BaseViewControllerProtocol: UIViewController {}

class Scene {
    let viewController: BaseViewControllerProtocol
    let viewModel: BaseViewModelProtocol

    init(viewController: BaseViewControllerProtocol, viewModel: any BaseViewModelProtocol) {
        self.viewController = viewController
        self.viewModel = viewModel
    }
}
