import SwiftUI

// MARK: - Animated Toggle Component
// Professional toggle with consistent styling and accessibility
struct AnimatedToggle: View {
    @Binding var isOn: Bool
    let label: String
    var description: String? = nil
    
    var body: some View {
        HStack(spacing: .spacingMD) {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.bodyMedium)
                    .foregroundColor(.textPrimary)
                
                if let description = description {
                    Text(description)
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .primaryBlue))
                .labelsHidden()
                .accessibilityLabel(label)
        }
        .padding(.spacingMD)
        .frame(minHeight: 44) // Accessible touch target
        .background(Color.cardDark)
        .cornerRadius(.radiusMD)
        .overlay(
            RoundedRectangle(cornerRadius: .radiusMD)
                .stroke(Color.surfaceSecondary.opacity(0.3), lineWidth: 0.5)
        )
    }
}
