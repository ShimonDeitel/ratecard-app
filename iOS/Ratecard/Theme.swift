import SwiftUI

/// Unique visual identity for Ratecard - Pricing Tiers.
enum Theme {
    static let accent = Color(red: 0.0588, green: 0.4627, blue: 0.4314)
    static let background = Color(red: 0.0392, green: 0.0863, blue: 0.0824)
    static let textPrimary = Color(red: 0.9176, green: 0.9647, blue: 0.9569)
    static let card = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .serif).weight(.semibold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static func statusColor(_ status: String) -> Color {
        switch status {
        case "Standard": return accent
        case "Package": return .gray
        default: return accent.opacity(0.7)
        }
    }
}
