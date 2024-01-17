@testable import CallMeMaybe

final class UIApplicationSpy: UIApplicationProtocol {

    private(set) var isIdleTimerDisabledParameters = [Bool]()

    var isIdleTimerDisabled: Bool = false {
        didSet {
            isIdleTimerDisabledParameters.append(isIdleTimerDisabled)
        }
    }
}
