import SwiftUI

// MARK: - Section Header Component
// Professional section header with consistent typography and spacing
// Provides clear visual hierarchy throughout the app
struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    var subtitle: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacingXS) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.heading2)
                        .foregroundColor(.textPrimary)
                    
                    // Optional subtitle for additional context
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    }
                }
                
                Spacer()
                
                // Optional action button
                if let actionTitle = actionTitle, let action = action {
                    Button(action: action) {
                        Text(actionTitle)
                            .font(.labelSmall)
                            .foregroundColor(.primaryBlue)
                    }
                    .buttonStyle(.interactive)
                }
            }
        }
        .padding(.horizontal, .spacingMD)
        .padding(.vertical, .spacingSM)
    }
}
