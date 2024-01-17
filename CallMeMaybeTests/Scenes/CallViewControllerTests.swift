import Quick
import Nimble

@testable import CallMeMaybe

final class CallViewControllerTests: QuickSpec {

    override class func spec() {

        var sut: CallViewController!

        var viewModelSpy: CallViewModelSpy!
        var viewSpy: CallView!

        beforeEach {
            viewModelSpy = CallViewModelSpy()
            viewSpy = CallView()

            sut = CallViewController(viewModel: viewModelSpy, contentView: viewSpy)
        }

        describe("#viewDidLoad") {
            beforeEach {
                sut.viewDidLoad()
            }

            it("sets title correctly") {
                expect(sut.title) == "Call me maybe"
            }

            context("bindLayoutEvents") {

                context("when calling view didTapReceiveCall closure") {
                    beforeEach {
                        viewSpy.didTapReceiveCall?()
                    }
                    it("calls viewModel didTapReceiveCall method with correct paremeter") {
                        expect(viewModelSpy.didTapReceiveCallCount) == 1
                    }
                }

                context("when calling view didTapMakeCall closure") {
                    beforeEach {
                        viewSpy.didTapMakeCall?()
                    }
                    it("calls viewModel didTapMakeCall method with correct paremeter") {
                        expect(viewModelSpy.didTapMakeCallCount) == 1
                    }
                }
            }
        }
    }
}
