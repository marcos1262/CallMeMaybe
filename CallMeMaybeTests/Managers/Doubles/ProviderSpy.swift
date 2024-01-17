import CallKit

@testable import CallMeMaybe

final class ProviderSpy: CXProviderProtocol {

    private(set) var setDelegateParameters = [(delegate: CXProviderDelegate?, queue: DispatchQueue?)]()
    private(set) var reportNewIncomingCallParameters = [(UUID: UUID, update: CXCallUpdate)]()

    func setDelegate(_ delegate: CXProviderDelegate?,
                     queue: DispatchQueue?) {
        setDelegateParameters.append((delegate, queue))
    }
    func reportNewIncomingCall(with UUID: UUID,
                               update: CXCallUpdate,
                               completion: @escaping (Error?) -> Void) {
        reportNewIncomingCallParameters.append((UUID, update))
    }
}
