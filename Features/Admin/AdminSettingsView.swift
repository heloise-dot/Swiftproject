import SwiftUI

struct AdminSettingsView: View {
    @State private var pushNotifications = true
    @State private var emailNotifications = true
    @State private var systemAlerts = true
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
                            
                            AnimatedToggle(isOn: $systemAlerts, label: "System Alerts")
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
                        SectionHeader(title: "System")
                        
                        VStack(spacing: 12) {
                            Button(action: {}) {
                                HStack {
                                    Text("Export Data")
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
                                    Text("System Logs")
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
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        AdminSettingsView()
    }
}

