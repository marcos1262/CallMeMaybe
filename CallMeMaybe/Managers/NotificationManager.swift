import PushKit

protocol NotificationManagerProtocol {
    func setup()
}

final class NotificationManager: NSObject {

    private let callingManager: CallingManagerProtocol
    private let voipRegistry: PKPushRegistry

    init(callingManager: CallingManagerProtocol) {
        self.callingManager = callingManager
        self.voipRegistry = PKPushRegistry(queue: .main)
        super.init()
    }
}

// MARK: - NotificationManagerProtocol

extension NotificationManager: NotificationManagerProtocol {

    func setup() {
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
    }
}

// MARK: - PKPushRegistryDelegate

extension NotificationManager: PKPushRegistryDelegate {

    func pushRegistry(_ registry: PKPushRegistry,
                      didUpdate pushCredentials: PKPushCredentials,
                      for type: PKPushType) {
        debugPrint("[DEBUG] Voip notification registering")
        // TODO: Send VoIP push credentials to some server
        let voipToken = pushCredentials.token.description
        debugPrint("[DEBUG] VoIP token", voipToken)
    }

    func pushRegistry(_ registry: PKPushRegistry,
                      didReceiveIncomingPushWith payload: PKPushPayload,
                      for type: PKPushType,
                      completion: @escaping () -> Void) {
        debugPrint("[DEBUG] Received call")
        // TODO: Receive call info from notification
        let mockUser = "Marcos Paulo"
        let mockCallId = "call-me-maybe"
        callingManager.didReceiveCall(from: mockUser, callId: mockCallId)
        completion()
    }

    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        debugPrint("[DEBUG] Voip notification register invalidation")
    }
}
