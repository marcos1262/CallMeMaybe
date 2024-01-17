final class CallViewModel {

    private let callingManager: CallingManagerProtocol

    private let mockUser = "Marcos Paulo"
    private let mockCallId = "test"

    init(callingManager: CallingManagerProtocol) {
        self.callingManager = callingManager
    }
}

// MARK: - CallViewModelProtocol

extension CallViewModel: CallViewModelProtocol {

    func didTapMakeCall() {
        callingManager.makeCall(to: mockUser, callId: mockCallId)
    }

    func didTapReceiveCall() {
        callingManager.didReceiveCall(from: mockUser, callId: mockCallId)
    }
}
