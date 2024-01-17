import Foundation

@testable import CallMeMaybe

final class DispatchQueueMock: DispatchQueueProtocol {

    func async(group: DispatchGroup?,
               qos: DispatchQoS,
               flags: DispatchWorkItemFlags,
               execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
