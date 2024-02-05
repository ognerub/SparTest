import Foundation
extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.timeZone = .current
        return formatter
    }()
    
    var formatted: String {
        return Date.formatter.string(from: self)
    }
}
