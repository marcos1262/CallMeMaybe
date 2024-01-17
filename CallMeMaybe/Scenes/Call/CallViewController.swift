import UIKit

final class CallViewController: UIViewController {

    private let viewModel: CallViewModelProtocol
    private let contentView: CallViewProtocol

    init(viewModel: CallViewModelProtocol,
         contentView: CallViewProtocol = CallView()) {
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.title
        bindLayoutEvents()
    }

    private func bindLayoutEvents() {
        contentView.didTapMakeCall = { [weak self] in
            self?.viewModel.didTapMakeCall()
        }
        contentView.didTapReceiveCall = { [weak self] in
            self?.viewModel.didTapReceiveCall()
        }
    }
}
