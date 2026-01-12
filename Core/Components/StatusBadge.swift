import SwiftUI

// MARK: - Status Badge Component
// Professional status indicator with consistent styling
// Designed for high visibility and clear communication
struct StatusBadge: View {
    let text: String
    let color: Color
    var size: BadgeSize = .medium
    
    enum BadgeSize {
        case small, medium, large
        
        var fontSize: Font {
            switch self {
            case .small: return .caption
            case .medium: return .labelSmall
            case .large: return .bodySmall
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .small: return 8
            case .medium: return 12
            case .large: return 16
            }
        }
        
        var verticalPadding: CGFloat {
            switch self {
            case .small: return 4
            case .medium: return 6
            case .large: return 8
            }
        }
    }
    
    var body: some View {
        Text(text)
            .font(size.fontSize)
            .fontWeight(.semibold)
            .foregroundColor(color)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .background(
                // High contrast background for accessibility
                Capsule()
                    .fill(color.opacity(0.15))
                    .overlay(
                        Capsule()
                            .stroke(color.opacity(0.3), lineWidth: 0.5)
                    )
            )
    }
}

// MARK: - Water Status Badge Variant
// Specialized badge for water status indicators
struct WaterStatusBadge: View {
    let status: WaterStatus
    
    private var color: Color {
        switch status {
        case .available: return .statusAvailable
        case .lowPressure: return .statusLowPressure
        case .scheduledMaintenance: return .statusMaintenance
        case .outage: return .statusOutage
        }
    }
    
    var body: some View {
        StatusBadge(text: status.rawValue, color: color)
    }
}
