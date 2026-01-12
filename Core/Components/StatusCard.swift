import SwiftUI

// MARK: - Status Card Component
// Professional card component for displaying area status
// Optimized for readability and visual hierarchy
struct StatusCard: View {
    let area: String
    let status: String
    let color: Color
    var subtitle: String? = nil
    
    @State private var animate = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacingMD) {
            // Area name - primary information
            Text(area)
                .font(.heading3)
                .foregroundColor(.textPrimary)
                .lineLimit(2)
            
            // Status badge
            StatusBadge(text: status, color: color)
            
            // Optional subtitle (e.g., water source)
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.spacingMD)
        .background(Color.cardDark)
        .cornerRadius(.radiusLG)
        .overlay(
            RoundedRectangle(cornerRadius: .radiusLG)
                .stroke(color.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 8)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                animate = true
            }
        }
    }
}
