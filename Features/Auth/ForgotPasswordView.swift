import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var isSubmitted = false
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                VStack(spacing: 16) {
                    Image(systemName: "lock.rotation")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.primaryBlue)
                    
                    Text("Reset Password")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.textPrimary)
                    
                    Text("Enter your email to receive reset instructions")
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                if !isSubmitted {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal, 24)
                    
                    PrimaryButton(title: "Send Reset Link") {
                        withAnimation {
                            isSubmitted = true
                        }
                    }
                    .padding(.horizontal, 24)
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                        
                        Text("Reset link sent!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.textPrimary)
                        
                        Text("Check your email for password reset instructions")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal, 24)
                    .transition(.scale.combined(with: .opacity))
                }
                
                Spacer()
                
                Button("Back to Login") {
                    dismiss()
                }
                .foregroundColor(.primaryBlue)
                .font(.subheadline)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}

