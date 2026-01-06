import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: AppRouter
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var selectedArea = "Kigali Central"
    
    let areas = ["Kigali Central", "Gasabo", "Nyarugenge", "Kicukiro"]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.primaryBlue)
                        
                        Text("Create Account")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text("Join us to stay informed")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.top, 20)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        customTextField(title: "Full Name", placeholder: "Enter your name", text: $name)
                        
                        customTextField(title: "Email", placeholder: "Enter your email", text: $email, keyboard: .emailAddress)
                        
                        customTextField(title: "Phone", placeholder: "Enter your phone", text: $phone, keyboard: .phonePad)
                        
                        // Area Picker
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Area")
                                .font(.subheadline)
                                .foregroundColor(.textSecondary)
                            
                            Picker("Area", selection: $selectedArea) {
                                ForEach(areas, id: \.self) { area in
                                    Text(area).tag(area)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                        }
                        
                        passwordField(title: "Password", placeholder: "Enter password", text: $password, isVisible: $showPassword)
                        
                        passwordField(title: "Confirm Password", placeholder: "Confirm password", text: $confirmPassword, isVisible: $showConfirmPassword)
                    }
                    
                    // Logic Update: Navigate using the Path
                    PrimaryButton(title: "Create Account") {
                        withAnimation {
                            // First, clear the login stack so they can't go "back" to register
                            router.path = NavigationPath()
                            // Then, push the main view
                            router.path.append("CustomerMain")
                        }
                    }
                    .padding(.top, 8)
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.textSecondary)
                        
                        Button("Login") {
                            dismiss()
                        }
                        .foregroundColor(.primaryBlue)
                        .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Views to clean up the code
    
    private func customTextField(title: String, placeholder: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            TextField(placeholder, text: text)
                .textFieldStyle(.plain)
                .padding()
                .background(Color.cardDark)
                .cornerRadius(12)
                .foregroundColor(.textPrimary)
                .keyboardType(keyboard)
                .autocapitalization(.none)
        }
    }
    
    private func passwordField(title: String, placeholder: String, text: Binding<String>, isVisible: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            HStack {
                if isVisible.wrappedValue {
                    TextField(placeholder, text: text)
                } else {
                    SecureField(placeholder, text: text)
                }
                Button(action: { isVisible.wrappedValue.toggle() }) {
                    Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.textSecondary)
                }
            }
            .padding()
            .background(Color.cardDark)
            .cornerRadius(12)
            .foregroundColor(.textPrimary)
        }
    }
}


