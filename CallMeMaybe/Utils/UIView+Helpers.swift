import UIKit

extension UIView {

    func fillToSuperview(padding: CGFloat = 0, safeArea: Bool = true) {
        guard let superView = superview else { return }

        if safeArea {
            anchor(top: superView.safeAreaLayoutGuide.topAnchor, padding: padding)
            anchor(leading: superView.safeAreaLayoutGuide.leadingAnchor, padding: padding)
            anchor(trailing: superView.safeAreaLayoutGuide.trailingAnchor, padding: padding)
            anchor(bottom: superView.safeAreaLayoutGuide.bottomAnchor, padding: padding)
        } else {
            anchor(top: superView.topAnchor, padding: padding)
            anchor(leading: superView.leadingAnchor, padding: padding)
            anchor(trailing: superView.trailingAnchor, padding: padding)
            anchor(bottom: superView.bottomAnchor, padding: padding)
        }
    }
}
