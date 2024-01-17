@testable import CallMeMaybe

final class PermissionsManagerSpy: PermissionsManagerProtocol {

    private(set) var checkForPermissionsCallCount = 0

    func checkForPermissions(completion: @escaping (Bool) -> Void) {
        checkForPermissionsCallCount += 1
        completion(true)
    }
}
