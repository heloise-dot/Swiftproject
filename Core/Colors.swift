import SwiftUI

// MARK: - Design System: Water-Inspired Color Palette
// Professional color palette for water utility system
// Designed for trust, clarity, and accessibility (WCAG AA compliance)

extension Color {
    // MARK: Primary Brand Colors - Water-Inspired
    /// Primary brand color: Deep ocean blue - conveys trust and reliability
    static let primaryBlue = Color(hex: "#0B6BC2") // Deep professional blue
    /// Primary brand accent: Calm teal - water-inspired accent
    static let primaryTeal = Color(hex: "#14B8A6") // Trustworthy teal
    
    // MARK: Background Colors
    /// Main background: Deep slate for dark mode - reduces eye strain
    static let backgroundDark = Color(hex: "#0F172A") // Slate 900
    /// Card/container background: Elevated surface with subtle transparency
    static let cardDark = Color(hex: "#1E293B") // Slate 800 - 100% opacity for better contrast
    /// Secondary surface: For nested containers or dividers
    static let surfaceSecondary = Color(hex: "#334155") // Slate 700
    
    // MARK: Text Colors
    /// Primary text: High contrast for readability
    static let textPrimary = Color(hex: "#F8FAFC") // Slate 50 - WCAG AAA contrast
    /// Secondary text: For supporting information
    static let textSecondary = Color(hex: "#CBD5E1") // Slate 300 - WCAG AA contrast
    /// Tertiary text: For subtle labels and hints
    static let textTertiary = Color(hex: "#94A3B8") // Slate 400
    
    // MARK: Semantic Colors - Status Indicators
    /// Success: Water available, system operational
    static let success = Color(hex: "#10B981") // Emerald 500
    /// Warning: Low pressure, scheduled maintenance
    static let warning = Color(hex: "#F59E0B") // Amber 500
    /// Error: Outage, critical issues
    static let error = Color(hex: "#EF4444") // Red 500
    /// Info: Neutral informational states
    static let info = Color(hex: "#3B82F6") // Blue 500
    
    // MARK: Water Status Colors
    /// Available: Water is flowing normally
    static let statusAvailable = Color(hex: "#10B981") // Emerald
    /// Low Pressure: Reduced service
    static let statusLowPressure = Color(hex: "#F59E0B") // Amber
    /// Maintenance: Scheduled work in progress
    static let statusMaintenance = Color(hex: "#F97316") // Orange 500
    /// Outage: Service unavailable
    static let statusOutage = Color(hex: "#EF4444") // Red
    
    // MARK: Interactive States
    /// Button hover/pressed state
    static let interactiveHover = Color(hex: "#075985") // Sky 800
    /// Disabled state
    static let disabled = Color(hex: "#475569") // Slate 600
}

// MARK: - Hex Color Initializer
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

// MARK: - Design Tokens: Spacing
// Consistent spacing scale for professional appearance
extension CGFloat {
    static let spacingXS: CGFloat = 4
    static let spacingSM: CGFloat = 8
    static let spacingMD: CGFloat = 16
    static let spacingLG: CGFloat = 24
    static let spacingXL: CGFloat = 32
    static let spacingXXL: CGFloat = 48
}

// MARK: - Design Tokens: Border Radius
// Consistent corner radius for professional polish
extension CGFloat {
    static let radiusSM: CGFloat = 8
    static let radiusMD: CGFloat = 12
    static let radiusLG: CGFloat = 16
    static let radiusXL: CGFloat = 20
}

// MARK: - Design Tokens: Typography
// Typography scale for clear information hierarchy
extension Font {
    /// Large display numbers (usage stats, totals)
    static let displayLarge = Font.system(size: 56, weight: .bold, design: .rounded)
    /// Medium display numbers
    static let displayMedium = Font.system(size: 48, weight: .bold, design: .rounded)
    /// Section headers
    static let heading1 = Font.system(size: 32, weight: .bold, design: .default)
    static let heading2 = Font.system(size: 24, weight: .semibold, design: .default)
    static let heading3 = Font.system(size: 20, weight: .semibold, design: .default)
    /// Body text
    static let bodyLarge = Font.system(size: 17, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 15, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 13, weight: .regular, design: .default)
    /// Labels and captions
    static let labelMedium = Font.system(size: 15, weight: .medium, design: .default)
    static let labelSmall = Font.system(size: 13, weight: .medium, design: .default)
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
}
