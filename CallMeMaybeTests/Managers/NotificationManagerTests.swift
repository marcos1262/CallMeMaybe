import Quick
import Nimble
import PushKit

@testable import CallMeMaybe

final class NotificationManagerTests: QuickSpec {

    override class func spec() {

        var sut: NotificationManager!

        var callingManagerSpy: CallingManagerSpy!

        beforeEach {
            callingManagerSpy = CallingManagerSpy()

            sut = NotificationManager(callingManager: callingManagerSpy)
        }

        describe("#setup") {
            beforeEach {
                sut.setup()
            }
            it("sets the property voipRegistry to PKPushRegistry instance") {
                let voipRegistry: PKPushRegistry? = Mirror.extract("voipRegistry", from: sut)
                expect(voipRegistry?.delegate).to(be(sut))
                expect(voipRegistry?.desiredPushTypes) == [.voIP]
            }
        }

        describe("#pushRegistry(_,didReceiveIncomingPushWith:,for:,completion:)") {
            beforeEach {
                sut.pushRegistry(PKPushRegistry(queue: .main),
                                 didReceiveIncomingPushWith: PKPushPayload(),
                                 for: .voIP) {}
            }
            it("calls callingManager correctly") {
                expect(callingManagerSpy.didReceiveCallParameters.count) == 1
                expect(callingManagerSpy.didReceiveCallParameters.first?.user) == "Marcos Paulo"
                expect(callingManagerSpy.didReceiveCallParameters.first?.callId) == "test"
            }
        }
    }
}

