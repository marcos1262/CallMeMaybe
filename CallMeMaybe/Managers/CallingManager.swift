import CallKit

protocol CallingManagerProtocol {
    func didReceiveCall(from user: String, callId: String)
    func makeCall(to user: String, callId: String)
}

final class CallingManager: NSObject {

    private let communicationManager: CommunicationManagerProtocol
    private let provider: CXProviderProtocol
    private let permissionsManager: PermissionsManagerProtocol

    private var currentCallId: String?

    init(communicationManager: CommunicationManagerProtocol = CommunicationManager(),
         permissionsManager: PermissionsManagerProtocol = PermissionsManager(),
         provider: CXProviderProtocol? = nil) {
        self.communicationManager = communicationManager
        self.permissionsManager = permissionsManager

        let config = CXProviderConfiguration(localizedName: "CallMeMaybe")
        self.provider = provider ?? CXProvider(configuration: config)

        super.init()
        setup()
    }

    private func setup() {
        provider.setDelegate(self, queue: nil)
    }

    private func reportNewIncomingCall(from user: String) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: user)
        provider.reportNewIncomingCall(with: UUID(), update: update) { error in
            if let error = error {
                debugPrint("[DEBUG] Error on receiving incoming call \(error)")
            } else {
                debugPrint("[DEBUG] Received income call successfully")
            }
        }
    }
}

// MARK: - CallingManagerProtocol

extension CallingManager: CallingManagerProtocol {

    func didReceiveCall(from user: String, callId: String) {
        currentCallId = callId
        permissionsManager.checkForPermissions { [weak self] granted in
            guard granted else {
                // TODO: handle permission denied
                return
            }
            self?.reportNewIncomingCall(from: user)
        }
    }

    func makeCall(to user: String, callId: String) {
        let recipient = CXHandle(type: .generic, value: user)
        let call = UUID()
        let startCallAction = CXStartCallAction(call: call, handle: recipient)
        let transaction = CXTransaction(action: startCallAction)
        let callController = CXCallController()
        callController.request(transaction, completion: { [weak self] error in
            if let error = error {
                debugPrint("[DEBUG] Error on requesting call transaction \(error)")
            } else {
                debugPrint("[DEBUG] Requested call transaction successfully")
                self?.communicationManager.didStartCall(with: callId)
            }
        })
    }
}

// MARK: - CXProviderDelegate

extension CallingManager: CXProviderDelegate {

    func providerDidReset(_ provider: CXProvider) {
        debugPrint("[DEBUG] Calling provider did reset")
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        guard let callId = currentCallId else { return action.fail() }

        communicationManager.didStartCall(with: callId)
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        currentCallId = nil
        communicationManager.didFinishCall()
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
        communicationManager.didToggleMuted(action.isMuted)
        action.fulfill()
    }
}
