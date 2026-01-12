import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject var router: AppRouter
    @State private var selectedRole: UserRole? = nil
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Header Section
                VStack(spacing: 16) {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .frame(width: 80, height: 60)
                        .foregroundColor(.primaryBlue)
                    
                    Text("Select Your Role")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.textPrimary)
                    
                    Text("Choose how you want to use the app")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                }
                
                // Role Selection Cards
                VStack(spacing: 20) {
                    RoleCard(
                        title: "Customer",
                        description: "Check water availability and receive updates",
                        icon: "person.fill",
                        isSelected: selectedRole == .customer
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedRole = .customer
                        }
                    }
                    
                    RoleCard(
                        title: "Admin",
                        description: "Manage water status and send notifications",
                        icon: "gearshape.fill",
                        isSelected: selectedRole == .admin
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedRole = .admin
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                // The "Continue" Button logic is updated here
                if let role = selectedRole {
                    PrimaryButton(title: "Continue") {
                        // Persist the role choice to the current user
                        router.currentUser?.role = role
                        
                        if role == .admin {
                            router.navigate(to: .adminMain)
                        } else {
                            router.navigate(to: .customerMain)
                        }
                    }
                    .padding(.horizontal, 24)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                Spacer()
            }
        }
        // This ensures the screen title is handled correctly by the NavigationStack
        .navigationTitle("Selection")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: - Supporting Views (RoleCard)
    struct RoleCard: View {
        let title: String
        let description: String
        let icon: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                HStack(spacing: 20) {
                    Image(systemName: icon)
                        .font(.title)
                        .foregroundColor(isSelected ? .primaryBlue : .textSecondary)
                        .frame(width: 50, height: 50)
                        .background(isSelected ? Color.primaryBlue.opacity(0.2) : Color.cardDark)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                        
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.primaryBlue)
                            .font(.title2)
                    }
                }
                .padding()
                .background(isSelected ? Color.primaryBlue.opacity(0.1) : Color.cardDark)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.primaryBlue : Color.clear, lineWidth: 2)
                )
            }
            .buttonStyle(.interactive)
        }
    }
}

#Preview {
    NavigationStack {
        RoleSelectionView()
            .environmentObject(AppRouter())
    }
}
