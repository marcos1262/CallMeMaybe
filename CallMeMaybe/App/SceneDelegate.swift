import UIKit

final class SceneDelegate: UIResponder {

    private var callingManager: CallingManagerProtocol?
    private var notificationManager: NotificationManagerProtocol?

    var window: UIWindow?

    private func setupDependencies() {
        let callingManager = CallingManager()
        let notificationManager = NotificationManager(callingManager: callingManager)
        notificationManager.setup()

        self.callingManager = callingManager
        self.notificationManager = notificationManager
    }

    private func setupController(_ callingManager: CallingManagerProtocol) -> UIViewController {
        let viewModel = CallViewModel(callingManager: callingManager)
        let controller = CallViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }

    private func setupWindow(_ scene: UIWindowScene?) {
        guard let scene, let callingManager else { return }

        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .systemBackground
        window?.tintColor = .systemOrange
        window?.rootViewController = setupController(callingManager)
        window?.makeKeyAndVisible()
    }
}

// MARK: - UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate{

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupDependencies()
        setupWindow(scene as? UIWindowScene)
    }
}
