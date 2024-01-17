@testable import CallMeMaybe

final class CallingManagerSpy: CallingManagerProtocol {

    private(set) var didReceiveCallParameters = [(user: String, callId: String)]()
    private(set) var makeCallParameters = [(user: String, callId: String)]()

    func didReceiveCall(from user: String, callId: String) {
        didReceiveCallParameters.append((user, callId))
    }
    func makeCall(to user: String, callId: String) {
        makeCallParameters.append((user, callId))
    }
}
