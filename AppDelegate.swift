import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var mainRouter = Services.shared.mainRouter

    private lazy var mainWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = .normal
        return window
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        mainRouter.start(with: mainWindow)
        return true
    }
}

