import UIKit

final class CallView: UIScrollView, CallViewProtocol {

    var didTapMakeCall: (() -> Void)?
    var didTapReceiveCall: (() -> Void)?

    private let makeCallButton: UIButton = {
        let view = UIButton(type: .custom)
        view.layer.cornerRadius = 8
        view.setTitle(LocalizedStrings.makeCall, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemOrange
        return view
    }()

    private let receiveCallButton: UIButton = {
        let view = UIButton(type: .custom)
        view.layer.cornerRadius = 8
        view.setTitle(LocalizedStrings.receiveCall, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemOrange
        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Spacing.medium
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground
        buildViewHierarchy()
        addConstraints()
        bindLayoutEvents()
    }

    private func buildViewHierarchy() {
        [makeCallButton, receiveCallButton, UIView()].forEach(stackView.addArrangedSubview)
        addSubview(stackView)
    }

    private func addConstraints() {
        makeCallButton.anchor(heightConstant: 44)
        receiveCallButton.anchor(heightConstant: 44)

        stackView.fillToSuperview(padding: Spacing.large, safeArea: false)
        stackView.anchor(width: widthAnchor, padding: 48)
    }

    private func bindLayoutEvents() {
        makeCallButton.addTarget(self,
                                 action: #selector(didTapMakeCallButton),
                                 for: .touchUpInside)
        receiveCallButton.addTarget(self,
                                    action: #selector(didTapReceiveCallButton),
                                    for: .touchUpInside)
    }

    @objc
    private func didTapMakeCallButton() {
        didTapMakeCall?()
    }

    @objc
    private func didTapReceiveCallButton() {
        didTapReceiveCall?()
    }
}
