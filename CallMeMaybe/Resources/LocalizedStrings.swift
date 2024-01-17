import Foundation

enum LocalizedStrings {
    static let title = localized("title")
    static let makeCall = localized("makeCall")
    static let receiveCall = localized("receiveCall")
}

extension LocalizedStrings {
    private static func localized(_ title: String) -> String {
        NSLocalizedString(title, comment: "")
    }
}
