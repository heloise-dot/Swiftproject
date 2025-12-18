import SwiftUI

extension Color {
    static let primaryBlue = Color(hex: "#3B82F6") // Vibrant Blue
    static let backgroundDark = Color(hex: "#0F172A") // Slate 900
    static let cardDark = Color(hex: "#1E293B").opacity(0.7) // Slate 800 with glass effect
    static let textPrimary = Color(hex: "#F8FAFC") // Slate 50
    static let textSecondary = Color(hex: "#94A3B8") // Slate 400
    static let success = Color(hex: "#22C55E")
    static let warning = Color(hex: "#EAB308")
    static let error = Color(hex: "#EF4444")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255
        )
    }
}
