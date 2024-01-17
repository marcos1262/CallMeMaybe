import AgoraRtcKit

protocol AgoraKitProtocol {
    @discardableResult func enableAudio() -> Int32
    @discardableResult func setDefaultAudioRouteToSpeakerphone(_ defaultToSpeaker: Bool) -> Int32
    @discardableResult func joinChannel(byToken token: String?,
                                        channelId: String,
                                        uid: UInt,
                                        mediaOptions: AgoraRtcChannelMediaOptions,
                                        joinSuccess joinSuccessBlock: ((String, UInt, Int) -> Void)?) -> Int32
    @discardableResult func leaveChannel(_ leaveChannelBlock: ((AgoraChannelStats) -> Void)?) -> Int32
    @discardableResult func muteLocalAudioStream(_ mute: Bool) -> Int32
    @discardableResult func setClientRole(_ role: AgoraClientRole) -> Int32
}

extension AgoraRtcEngineKit: AgoraKitProtocol {}
