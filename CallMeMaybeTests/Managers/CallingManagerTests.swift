import Quick
import Nimble
import CallKit

@testable import CallMeMaybe

final class CallingManagerTests: QuickSpec {

    override class func spec() {

        var sut: CallingManager!

        var communicationManagerSpy: CommunicationManagerSpy!
        var permissionsManagerSpy: PermissionsManagerSpy!
        var providerSpy: ProviderSpy!

        beforeEach {
            communicationManagerSpy = CommunicationManagerSpy()
            permissionsManagerSpy = PermissionsManagerSpy()
            providerSpy = ProviderSpy()

            sut = CallingManager(communicationManager: communicationManagerSpy,
                                 permissionsManager: permissionsManagerSpy,
                                 provider: providerSpy)
        }

        describe("#init") {

            context("with default paramaters") {
                beforeEach {
                    sut = CallingManager()
                }
                it("sets the property provier to CXProvider instance") {
                    let provider: CXProvider? = Mirror.extract("provider", from: sut)
                    expect(provider).toNot(beNil())
                }
            }

            context("with mock parameters") {
                it("sets provider's delegate correctly") {
                    expect(providerSpy.setDelegateParameters.count) == 1
                    expect(providerSpy.setDelegateParameters.first?.delegate).to(be(sut))
                    expect(providerSpy.setDelegateParameters.first?.queue).to(beNil())
                }
            }
        }

        describe("#didReceiveCall") {
            beforeEach {
                sut.didReceiveCall(from: "user", callId: "id")
            }
            it("sets the property currentCallId correctly") {
                let currentCallId: String? = Mirror.extract("currentCallId", from: sut)
                expect(currentCallId) == "id"
            }
            it("chacks for permission") {
                expect(permissionsManagerSpy.checkForPermissionsCallCount) == 1
            }
            it("reports income call") {
                expect(providerSpy.reportNewIncomingCallParameters.count) == 1
            }
        }

        describe("#makeCall") {
            beforeEach {
                sut.makeCall(to: "user", callId: "id")
            }
            it("calls communicationManager correctly") {
                expect(communicationManagerSpy.didStartCallParameters).toEventually(equal(["id"]))
            }
        }

        describe("#provider(_,perform: CXAnswerCallAction)") {
            context("when currentCallId is Nil") {
                beforeEach {
                    let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: ""))
                    sut.provider(provider, perform: CXAnswerCallAction(call: UUID()))
                }
                it("calls communicationManager correctly") {
                    expect(communicationManagerSpy.didStartCallParameters) == []
                }
            }

            context("when there is currentCallId") {
                beforeEach {
                    sut.didReceiveCall(from: "user", callId: "id")
                    let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: ""))
                    sut.provider(provider, perform: CXAnswerCallAction(call: UUID()))
                }
                it("calls communicationManager correctly") {
                    expect(communicationManagerSpy.didStartCallParameters) == ["id"]
                }
            }
        }

        describe("#provider(_,perform: CXEndCallAction)") {
            beforeEach {
                let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: ""))
                sut.provider(provider, perform: CXEndCallAction(call: UUID()))
            }
            it("calls communicationManager correctly") {
                expect(communicationManagerSpy.didFinishCallCallCount) == 1
            }
            it("sets the property currentCallId correctly") {
                let currentCallId: String? = Mirror.extract("currentCallId", from: sut)
                expect(currentCallId).to(beNil())
            }
        }

        describe("#provider(_,perform: CXSetMutedCallAction)") {
            beforeEach {
                let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: ""))
                sut.provider(provider, perform: CXSetMutedCallAction(call: UUID(), muted: true))
            }
            it("calls communicationManager correctly") {
                expect(communicationManagerSpy.didToggleMutedParameters) == [true]
            }
        }
    }
}

