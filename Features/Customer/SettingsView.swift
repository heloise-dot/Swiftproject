import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: AppRouter
    @State private var pushNotifications = true
    @State private var emailNotifications = true
    @State private var outageAlerts = true
    @State private var usageReports = false
    @State private var darkMode = true
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        SectionHeader(title: "Notifications")
                        
                        VStack(spacing: 12) {
                            AnimatedToggle(isOn: $pushNotifications, label: "Push Notifications")
                            
                            AnimatedToggle(isOn: $emailNotifications, label: "Email Notifications")
                            
                            AnimatedToggle(isOn: $outageAlerts, label: "Outage Alerts")
                            
                            AnimatedToggle(isOn: $usageReports, label: "Usage Reports")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Appearance")
                        
                        VStack(spacing: 12) {
                            AnimatedToggle(isOn: $darkMode, label: "Dark Mode")
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Account")
                        
                        VStack(spacing: 12) {
                            Button(action: {}) {
                                HStack {
                                    Text("Change Password")
                                        .foregroundColor(.textPrimary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.textSecondary)
                                }
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("Privacy Policy")
                                        .foregroundColor(.textPrimary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.textSecondary)
                                }
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {}) {
                                HStack {
                                    Text("Terms of Service")
                                        .foregroundColor(.textPrimary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.textSecondary)
                                }
                                .padding()
                                .background(Color.cardDark)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Button(action: {
                        withAnimation {
                            router.popToRoot()
                            router.currentUser = nil
                        }
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

