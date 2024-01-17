import Quick
import Nimble

@testable import CallMeMaybe

final class CallViewModelTests: QuickSpec {

    override class func spec() {

        var sut: CallViewModel!

        var callingManagerSpy: CallingManagerSpy!

        beforeEach {
            callingManagerSpy = CallingManagerSpy()

            sut = CallViewModel(callingManager: callingManagerSpy)
        }

        describe("#didTapReceiveCall") {
            beforeEach {
                sut.didTapReceiveCall()
            }
            it("calls callingManager didReceiveCall with correct parameters") {
                expect(callingManagerSpy.didReceiveCallParameters.count) == 1
                expect(callingManagerSpy.didReceiveCallParameters.first?.user) == "Marcos Paulo"
                expect(callingManagerSpy.didReceiveCallParameters.first?.callId) == "test"
            }
        }

        describe("#didTapMakeCall") {
            beforeEach {
                sut.didTapMakeCall()
            }
            it("calls callingManager makeCall with correct parameters") {
                expect(callingManagerSpy.makeCallParameters.count) == 1
                expect(callingManagerSpy.makeCallParameters.first?.user) == "Marcos Paulo"
                expect(callingManagerSpy.makeCallParameters.first?.callId) == "test"
            }
        }
    }
}
