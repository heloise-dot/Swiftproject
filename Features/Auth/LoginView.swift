import SwiftUI

// MARK: - Authentication Support
enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials
    case userNotFound
    case emailAlreadyInUse
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password."
        case .userNotFound:
            return "User not found."
        case .emailAlreadyInUse:
            return "Email is already in use."
        case .networkError:
            return "Network error. Please try again."
        }
    }
}

class AuthenticationService {
    static let shared = AuthenticationService()
    
    private init() {}
    
    // Mock database
    private var mockUsers: [String: User] = [:]
    
    func signIn(email: String, password: String) async throws -> User {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        let targetEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let targetPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("Attempting login for: \(targetEmail)")
        
        // 1. Hardcoded Admin
        if targetEmail == "admin@water.com" && targetPassword == "admin123" {
            return User(
                name: "System Admin",
                email: "admin@water.com",
                phone: "+250 788 000 000",
                address: "Kigali HQ",
                role: .admin,
                area: "Kigali Central"
            )
        }
        
        // 2. Hardcoded Customer
        if targetEmail == "user@water.com" && targetPassword == "user123" {
            return User(
                name: "John Doe",
                email: "user@water.com",
                phone: "+250 788 111 222",
                address: "Nyarugenge, Kigali",
                role: .customer,
                area: "Nyarugenge"
            )
        }
        
        // 3. Easy Test User
        if targetEmail == "test@water.com" && targetPassword == "test123" {
            return User(
                name: "Test User",
                email: "test@water.com",
                phone: "+250 788 333 444",
                address: "Gasabo, Kigali",
                role: .customer,
                area: "Gasabo"
            )
        }
        
        // 4. Fallback: Check registered users (in-memory)
        if let user = mockUsers[targetEmail] {
            // For mock purposes, any password works if user exists in memory
            return user
        }
        
        print("Login failed for: \(targetEmail)")
        throw AuthenticationError.invalidCredentials
    }
    
    func signUp(name: String, email: String, phone: String, area: String, password: String) async throws -> User {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        let targetEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if mockUsers[targetEmail] != nil {
            throw AuthenticationError.emailAlreadyInUse
        }
        
        let newUser = User(
            name: name,
            email: targetEmail,
            phone: phone,
            address: area,
            role: .customer,
            area: area
        )
        
        mockUsers[targetEmail] = newUser
        print("User registered: \(targetEmail)")
        return newUser
    }
    
    func signOut() {}
}


// MARK: - Login View
// Production-ready authentication screen with improved UX
// Focuses on clarity, trust, and accessibility
struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoading = false
    @State private var showError = false
    
    var body: some View {
        ZStack {
                // Background gradient for visual interest
                LinearGradient(
                    colors: [Color.backgroundDark, Color.backgroundDark.opacity(0.95)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: .spacingXXL) {
                        Spacer(minLength: .spacingXXL)
                        
                        // MARK: Brand Header
                        // Clear brand identity builds trust
                        VStack(spacing: .spacingMD) {
                            // Water drop icon with subtle animation
                            ZStack {
                                Circle()
                                    .fill(Color.primaryBlue.opacity(0.1))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "drop.fill")
                                    .resizable()
                                    .frame(width: 50, height: 65)
                                    .foregroundColor(.primaryBlue)
                                    .symbolEffect(.pulse, options: .repeating.speed(0.5))
                            }
                            
                            VStack(spacing: .spacingSM) {
                                Text("Water Utility")
                                    .font(.heading1)
                                    .foregroundColor(.textPrimary)
                                
                                Text("Monitor • Manage • Maintain")
                                    .font(.bodyMedium)
                                    .foregroundColor(.textSecondary)
                            }
                        }
                        .padding(.bottom, .spacingLG)
                        
                        // MARK: Login Form
                        // Professional form layout with clear visual hierarchy
                        VStack(spacing: .spacingLG) {
                            // Email Field
                            VStack(alignment: .leading, spacing: .spacingSM) {
                                Text("Email Address")
                                    .font(.labelMedium)
                                    .foregroundColor(.textSecondary)
                                
                                TextField("your.email@example.com", text: $email)
                                    .font(.bodyLarge)
                                    .foregroundColor(.textPrimary)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .textContentType(.emailAddress)
                                    .padding(.horizontal, .spacingMD)
                                    .frame(height: 56)
                                    .background(Color.cardDark)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .radiusMD)
                                            .stroke(email.isEmpty ? Color.surfaceSecondary.opacity(0.3) : Color.primaryBlue.opacity(0.5), lineWidth: 1)
                                    )
                                    .cornerRadius(.radiusMD)
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: .spacingSM) {
                                Text("Password")
                                    .font(.labelMedium)
                                    .foregroundColor(.textSecondary)
                                
                                HStack(spacing: .spacingSM) {
                                    Group {
                                        if showPassword {
                                            TextField("Enter password", text: $password)
                                        } else {
                                            SecureField("Enter password", text: $password)
                                        }
                                    }
                                    .font(.bodyLarge)
                                    .foregroundColor(.textPrimary)
                                    .textContentType(.password)
                                    
                                    // Show/Hide password toggle
                                    Button(action: {
                                        withAnimation(.spring(response: 0.3)) {
                                            showPassword.toggle()
                                        }
                                    }) {
                                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                            .font(.bodyMedium)
                                            .foregroundColor(.textSecondary)
                                            .frame(width: 44, height: 44) // Accessible touch target
                                    }
                                }
                                .padding(.leading, .spacingMD)
                                .padding(.trailing, .spacingXS)
                                .frame(height: 56)
                                .background(Color.cardDark)
                                .overlay(
                                    RoundedRectangle(cornerRadius: .radiusMD)
                                        .stroke(password.isEmpty ? Color.surfaceSecondary.opacity(0.3) : Color.primaryBlue.opacity(0.5), lineWidth: 1)
                                )
                                .cornerRadius(.radiusMD)
                            }
                            
                            // Forgot Password Link
                            HStack {
                                Spacer()
                                Button("Forgot Password?") {
                                    router.showForgotPassword = true
                                }
                                .font(.labelSmall)
                                .foregroundColor(.primaryBlue)
                            }
                        }
                        .padding(.horizontal, .spacingMD)
                        
                        // MARK: Action Buttons
                        VStack(spacing: .spacingMD) {
                            // Primary Login Button
                            Button(action: signIn) {
                                HStack(spacing: .spacingSM) {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    } else {
                                        Text("Sign In")
                                            .font(.labelMedium)
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52) // Comfortable touch target
                                .background(email.isEmpty || password.isEmpty ? Color.disabled : Color.primaryBlue)
                                .cornerRadius(.radiusMD)
                                .shadow(
                                    color: email.isEmpty || password.isEmpty ? .clear : Color.primaryBlue.opacity(0.4),
                                    radius: 12,
                                    x: 0,
                                    y: 6
                                )
                            }
                            .buttonStyle(.interactive)
                            .disabled(email.isEmpty || password.isEmpty || isLoading)
                            
                            if showError {
                                Text("Invalid email or password.")
                                    .font(.labelSmall)
                                    .foregroundColor(.red)
                            }
                            
                            // Sign Up Link
                            HStack(spacing: .spacingXS) {
                                Text("Don't have an account?")
                                    .font(.bodyMedium)
                                    .foregroundColor(.textSecondary)
                                
                                NavigationLink("Sign Up") {
                                    RegisterView()
                                }
                                .font(.labelMedium)
                                .foregroundColor(.primaryBlue)
                                .fontWeight(.semibold)
                            }
                        }
                        .padding(.horizontal, .spacingMD)
                        
                        Spacer(minLength: .spacingXL)
                    }
                }
            }
        }
    
    // MARK: - Sign In Logic
    private func signIn() {
        isLoading = true
        showError = false
        
        Task {
            do {
                let user = try await AuthenticationService.shared.signIn(email: email, password: password)
                
                await MainActor.run {
                    router.currentUser = user
                    isLoading = false
                    
                    router.navigate(to: .roleSelection)
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    showError = true
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppRouter())
}

