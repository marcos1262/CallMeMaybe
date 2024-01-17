import AVFoundation

protocol PermissionsManagerProtocol {
    func checkForPermissions(completion: @escaping (Bool) -> Void)
}

final class PermissionsManager {

    private func avAuthorization(mediaType: AVMediaType, completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: mediaType) {
        case .denied, .restricted:
            completion(false)
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType, completionHandler: completion)
        @unknown default:
            completion(false)
        }
    }
}

// MARK: - PermissionsManagerProtocol

extension PermissionsManager: PermissionsManagerProtocol {

    func checkForPermissions(completion: @escaping (Bool) -> Void) {
        avAuthorization(mediaType: .audio, completion: completion)
    }
}
