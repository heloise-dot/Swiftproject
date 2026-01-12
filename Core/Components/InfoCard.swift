import SwiftUI

// MARK: - Info Card Component
// Professional information card for displaying key metrics
// Used throughout the app for consistent data presentation
struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    var action: (() -> Void)? = nil
    
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack(spacing: .spacingMD) {
                // Icon container - visually distinct
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 44, height: 44) // Accessible touch target
                    .background(color.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: .radiusSM))
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.labelSmall)
                        .foregroundColor(.textSecondary)
                    
                    Text(value)
                        .font(.heading3)
                        .foregroundColor(.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                
                Spacer()
                
                // Navigation indicator
                if action != nil {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(.spacingMD)
            .background(Color.cardDark)
            .cornerRadius(.radiusLG)
            .overlay(
                RoundedRectangle(cornerRadius: .radiusLG)
                    .stroke(Color.surfaceSecondary.opacity(0.3), lineWidth: 0.5)
            )
        }
        .buttonStyle(.interactive)
        .disabled(action == nil)
    }
}
