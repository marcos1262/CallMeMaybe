@testable import CallMeMaybe

final class CallViewModelSpy: CallViewModelProtocol {

    private(set) var didTapReceiveCallCount = 0
    private(set) var didTapMakeCallCount = 0

    func didTapReceiveCall() {
        didTapReceiveCallCount += 1
    }
    func didTapMakeCall() {
        didTapMakeCallCount += 1
    }
}
