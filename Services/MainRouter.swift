import UIKit

protocol MainRouterProtocol {
    func start(with window: UIWindow)
    func present(_ scene: Scene)
}

final class MainRouter: MainRouterProtocol {

    // MARK: - App start

    private var window: UIWindow?

    func start(with window: UIWindow) {
        self.window = window
        window.windowLevel = .normal
        window.makeKeyAndVisible()

        presentAsRoot(scene: .home)
    }

    func present(_ scene: Scene) {
        window?.rootViewController?.present(scene.viewController, animated: true)
    }

    private func presentAsRoot(scene: Scene) {
        window?.rootViewController = scene.viewController
    }
}
