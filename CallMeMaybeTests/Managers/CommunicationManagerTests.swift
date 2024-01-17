import Quick
import Nimble
import AgoraRtcKit

@testable import CallMeMaybe

final class CommunicationManagerTests: QuickSpec {

    override class func spec() {

        var sut: CommunicationManager!

        var agoraKitSpy: AgoraKitSpy!
        var uiApplicationSpy: UIApplicationSpy!

        beforeEach {
            agoraKitSpy = AgoraKitSpy()
            uiApplicationSpy = UIApplicationSpy()

            sut = CommunicationManager(agoraKit: agoraKitSpy,
                                       uiApplication: uiApplicationSpy,
                                       dispatchQueue: DispatchQueueMock())
        }

        describe("#init") {

            context("with default paramaters") {
                beforeEach {
                    sut = CommunicationManager()
                }
                it("sets the property agoraKit to AgoraRtcEngineKit instance") {
                    let agoraKit: AgoraRtcEngineKit? = Mirror.extract("agoraKit", from: sut)
                    expect(agoraKit) == AgoraRtcEngineKit.sharedEngine(withAppId: "6839bee073444f04a4364a00b97b748d",
                                                                       delegate: sut)
                }
                it("sets the property uiApplication to AgoraRtcEngineKit instance") {
                    let uiApplication: UIApplication? = Mirror.extract("uiApplication", from: sut)
                    expect(uiApplication) == UIApplication.shared
                }
            }

            context("with mock parameters") {
                it("sets up agoraKit correctly") {
                    expect(agoraKitSpy.enableAudioCallCount) == 1
                    expect(agoraKitSpy.setClientRoleParameters) == [.broadcaster]
                }
            }
        }

        describe("#didStartCall") {
            beforeEach {
                sut.didStartCall(with: "id")
            }
            it("joins channel correctly") {
                expect(agoraKitSpy.setDefaultAudioRouteToSpeakerphoneParameters) == [true]

                expect(agoraKitSpy.joinChannelParameters.count) == 1
                expect(agoraKitSpy.joinChannelParameters.first?.token).to(beNil())
                expect(agoraKitSpy.joinChannelParameters.first?.channelId) == "id"
                expect(agoraKitSpy.joinChannelParameters.first?.uid) == 0

                expect(uiApplicationSpy.isIdleTimerDisabledParameters) == [true]
            }
        }

        describe("#didFinishCall") {
            beforeEach {
                sut.didFinishCall()
            }
            it("leaves channel correctly") {
                expect(agoraKitSpy.leaveChannelCallCount) == 1

                expect(uiApplicationSpy.isIdleTimerDisabledParameters) == [false]
            }
        }

        describe("#didToggleMuted") {
            beforeEach {
                sut.didToggleMuted(true)
            }
            it("toggles mute correctly") {
                expect(agoraKitSpy.muteLocalAudioStreamParameters) == [true]
            }
        }
    }
}
