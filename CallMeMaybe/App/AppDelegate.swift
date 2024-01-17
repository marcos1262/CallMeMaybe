import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        debugPrint("[DEBUG] push notification token", token)
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("[DEBUG] Did receive remote notification", userInfo)
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("[DEBUG] Error on registering for remote notifications", error)
    }
}
