import Quick
import Nimble
import UIKit

@testable import CallMeMaybe

final class CallViewTests: QuickSpec {

    override class func spec() {

        var sut: CallView!

        beforeEach {
            sut = CallView()
        }

        describe("#bindLayoutEvents") {
            context("when user taps on make call") {
                var closureCallCount = 0
                beforeEach {
                    sut.didTapMakeCall = {
                        closureCallCount += 1
                    }
                    let makeCallButton: UIButton? = Mirror.extract("makeCallButton", from: sut)
                    makeCallButton?.sendActions(for: .touchUpInside)
                }
                it("calls didTapMakeCall closure") {
                    expect(closureCallCount) == 1
                }
            }

            context("when user taps on receive call") {
                var closureCallCount = 0
                beforeEach {
                    sut.didTapReceiveCall = {
                        closureCallCount += 1
                    }
                    let receiveCallButton: UIButton? = Mirror.extract("receiveCallButton", from: sut)
                    receiveCallButton?.sendActions(for: .touchUpInside)
                }
                it("calls didTapReceiveCall closure") {
                    expect(closureCallCount) == 1
                }
            }
        }
    }
}
