import UIKit

protocol CallViewModelProtocol {
    func didTapMakeCall()
    func didTapReceiveCall()
}

protocol CallViewProtocol where Self: UIView {
    var didTapMakeCall: (() -> Void)? { get set }
    var didTapReceiveCall: (() -> Void)? { get set }
}
