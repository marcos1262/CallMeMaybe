@testable import CallMeMaybe

final class CommunicationManagerSpy: CommunicationManagerProtocol {

    private(set) var didStartCallParameters = [String]()
    private(set) var didFinishCallCallCount = 0
    private(set) var didToggleMutedParameters = [Bool]()

    func didStartCall(with id: String) {
        didStartCallParameters.append(id)
    }
    func didFinishCall() {
        didFinishCallCallCount += 1
    }
    func didToggleMuted(_ isMuted: Bool) {
        didToggleMutedParameters.append(isMuted)
    }
}
