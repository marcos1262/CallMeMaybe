import UIKit

protocol UIApplicationProtocol {
    var isIdleTimerDisabled: Bool { get set }
}

extension UIApplication: UIApplicationProtocol {}
