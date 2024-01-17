import AgoraRtcKit

@testable import CallMeMaybe

final class AgoraKitSpy: AgoraKitProtocol {

    private(set) var enableAudioCallCount = 0
    private(set) var setDefaultAudioRouteToSpeakerphoneParameters = [Bool]()
    private(set) var joinChannelParameters = [(token: String?,
                                               channelId: String,
                                               uid: UInt,
                                               mediaOptions: AgoraRtcChannelMediaOptions)]()
    private(set) var leaveChannelCallCount = 0
    private(set) var muteLocalAudioStreamParameters = [Bool]()
    private(set) var setClientRoleParameters = [AgoraClientRole]()

    @discardableResult func enableAudio() -> Int32 {
        enableAudioCallCount += 1
        return 0
    }
    @discardableResult func setDefaultAudioRouteToSpeakerphone(_ defaultToSpeaker: Bool) -> Int32 {
        setDefaultAudioRouteToSpeakerphoneParameters.append(defaultToSpeaker)
        return 0
    }
    @discardableResult func joinChannel(byToken token: String?,
                                        channelId: String,
                                        uid: UInt,
                                        mediaOptions: AgoraRtcChannelMediaOptions,
                                        joinSuccess joinSuccessBlock: ((String, UInt, Int) -> Void)?) -> Int32 {
        joinChannelParameters.append((token, channelId, uid, mediaOptions))
        return 0
    }
    @discardableResult func leaveChannel(_ leaveChannelBlock: ((AgoraChannelStats) -> Void)?) -> Int32 {
        leaveChannelCallCount += 1
        return 0
    }
    @discardableResult func muteLocalAudioStream(_ mute: Bool) -> Int32 {
        muteLocalAudioStreamParameters.append(mute)
        return 0
    }
    @discardableResult func setClientRole(_ role: AgoraClientRole) -> Int32 {
        setClientRoleParameters.append(role)
        return 0
    }
}
