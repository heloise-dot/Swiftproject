import SwiftUI

// MARK: - Primary Button Component
// Production-ready button with proper accessibility and touch targets
// Minimum 44x44pt touch target for iOS accessibility guidelines
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var icon: String? = nil
    var isLoading: Bool = false
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: .spacingSM) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.9)
                } else if let icon = icon {
                    Image(systemName: icon)
                        .font(.bodyMedium)
                }
                
                Text(title)
                    .font(.labelMedium)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50) // Accessible touch target (44pt minimum + padding)
            .background(isDisabled ? Color.disabled : Color.primaryBlue)
            .cornerRadius(.radiusMD)
            .shadow(
                color: isDisabled ? .clear : Color.primaryBlue.opacity(0.3),
                radius: 8,
                x: 0,
                y: 4
            )
        }
        .buttonStyle(.interactive)
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled ? 0.6 : 1.0)
    }
}

// MARK: - Secondary Button Variant
// For less prominent actions
struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    var icon: String? = nil
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: .spacingSM) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.bodyMedium)
                }
                
                Text(title)
                    .font(.labelMedium)
                    .foregroundColor(.primaryBlue)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.cardDark)
            .overlay(
                RoundedRectangle(cornerRadius: .radiusMD)
                    .stroke(Color.primaryBlue.opacity(0.5), lineWidth: 1.5)
            )
            .cornerRadius(.radiusMD)
        }
        .buttonStyle(.interactive)
    }
}

// MARK: - Destructive Button Variant
// For actions like delete or sign out
struct DestructiveButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.labelMedium)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.error)
                .cornerRadius(.radiusMD)
        }
        .buttonStyle(.interactive)
    }
}
