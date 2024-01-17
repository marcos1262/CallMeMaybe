import AgoraRtcKit

protocol CommunicationManagerProtocol {
    func didStartCall(with id: String)
    func didFinishCall()
    func didToggleMuted(_ isMuted: Bool)
}

final class CommunicationManager: NSObject {

    private var agoraKit: AgoraKitProtocol?
    private var uiApplication: UIApplicationProtocol
    private let dispatchQueue: DispatchQueueProtocol

    private let appID: String = "6839bee073444f04a4364a00b97b748d"
//    private let channelName: String = "test"
//    private let token = "007eJxTYDiXvsPvoe82/ZPrF287famlaoHDlTuzMlfs9X/pmjbZh3ORAoOZhbFlUmqqgbmxiYl" +
//    "JmoFJoomxmUmigUGSpXmSuYlFSsGnZakNgYwMv1uZWRgZIBDEZ2EoSS0uYWAAAB93IfQ="
//    private let rtcToken = "007eJxTYPi6xaFY+9guFclNv3q7p50L2heX0PRXPzdHceoifVcfZlMFBjMLY8uk1FQDc2MT" +
//    "E5M0A5NEE2Mzk0QDgyRL8yRzE4sUw5ZlqQ2BjAxZfnIMjFAI4vMyJCfm5OjmpurmJlYmpTIwAAAo6yCn"

    init(agoraKit: AgoraKitProtocol? = nil,
         uiApplication: UIApplicationProtocol = UIApplication.shared,
         dispatchQueue: DispatchQueueProtocol = DispatchQueue.main) {
        self.uiApplication = uiApplication
        self.dispatchQueue = dispatchQueue
        super.init()
        self.agoraKit = agoraKit ?? AgoraRtcEngineKit.sharedEngine(withAppId: appID, delegate: self)
        setup()
    }

    private func setup() {
        agoraKit?.enableAudio()
        agoraKit?.setClientRole(.broadcaster)
    }

    private func joinChannel(id: String) {
        agoraKit?.setDefaultAudioRouteToSpeakerphone(true)
        let opt = AgoraRtcChannelMediaOptions()
        opt.channelProfile = .communication
        agoraKit?.joinChannel(byToken: nil, channelId: id, uid: 0, mediaOptions: opt) { _,_,_ in
            debugPrint("[DEBUG] User did join channel")
        }
        uiApplication.isIdleTimerDisabled = true
    }

    private func leaveChannel() {
        agoraKit?.leaveChannel { _ in
            debugPrint("[DEBUG] User did leave channel")
        }
        uiApplication.isIdleTimerDisabled = false
    }
}

// MARK: - CommunicationManagerProtocol

extension CommunicationManager: CommunicationManagerProtocol {

    func didStartCall(with id: String) {
        dispatchQueue.async { [weak self] in
            self?.joinChannel(id: id)
        }
    }

    func didFinishCall() {
        dispatchQueue.async { [weak self] in
            self?.leaveChannel()
        }
    }

    func didToggleMuted(_ isMuted: Bool) {
        agoraKit?.muteLocalAudioStream(isMuted)
    }
}

// MARK: - AgoraRtcEngineDelegate

extension CommunicationManager: AgoraRtcEngineDelegate {

    func rtcEngine(_ engine: AgoraRtcEngineKit,
                   didJoinChannel channel: String,
                   withUid uid: UInt,
                   elapsed: Int) {
        debugPrint("[DEBUG] The local user has successfully joined the channel")
    }

    func rtcEngine(_ engine: AgoraRtcEngineKit,
                   didJoinedOfUid uid: UInt,
                   elapsed: Int) {
        debugPrint("[DEBUG] A remote user has joined the channel")
    }

    func rtcEngine(_ engine: AgoraRtcEngineKit,
                   didOfflineOfUid uid: UInt,
                   reason: AgoraUserOfflineReason) {
        debugPrint("[DEBUG] A remote user has left the channel")
    }
}
