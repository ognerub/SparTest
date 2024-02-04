import UIKit
extension String {
    
    enum Source: String {
        case common = "Localizable"
    }
    func localized(
        from source: Source = .common,
        _ bundle: Bundle = Bundle.main,
        _ comment: String = "") -> String {
            var notFoundValue = self
            if source != .common {
                notFoundValue = NSLocalizedString(
                    self,
                    tableName: Source.common.rawValue,
                    bundle: bundle,
                    comment: comment)
            }
            return NSLocalizedString(
                self,
                tableName: source.rawValue,
                bundle: bundle,
                value: notFoundValue,
                comment: comment)
        }
}

