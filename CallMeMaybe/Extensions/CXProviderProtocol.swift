import CallKit

protocol CXProviderProtocol {
    func setDelegate(_ delegate: CXProviderDelegate?, queue: DispatchQueue?)
    func reportNewIncomingCall(with UUID: UUID, update: CXCallUpdate, completion: @escaping (Error?) -> Void)
}

extension CXProvider: CXProviderProtocol {}
