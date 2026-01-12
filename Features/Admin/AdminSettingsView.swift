import SwiftUI

struct AdminSettingsView: View {
    @EnvironmentObject var router: AppRouter
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
                        SectionHeader(title: "Storage Management")
                        
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Application Cache")
                                        .foregroundColor(.textPrimary)
                                    Text("24.5 MB")
                                        .font(.caption)
                                        .foregroundColor(.textSecondary)
                                }
                                Spacer()
                                Button(action: {
                                    let impact = UIImpactFeedbackGenerator(style: .medium)
                                    impact.impactOccurred()
                                }) {
                                    Text("Clear")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primaryBlue)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.primaryBlue.opacity(0.1))
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.interactive)
                            }
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
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
                            NavigationLink(value: AppRoute.exportData) {
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
                            .buttonStyle(.interactive)
                            
                            NavigationLink(value: AppRoute.systemLogs) {
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
                            .buttonStyle(.interactive)
                            
                            NavigationLink(value: AppRoute.privacyPolicy) {
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
                            .buttonStyle(.interactive)
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "App Information")
                        
                        VStack(spacing: 0) {
                            InfoRow(title: "Version", value: "1.2.0 (Alpha)")
                            Divider().background(Color.white.opacity(0.1)).padding(.horizontal)
                            InfoRow(title: "Build Number", value: "20260112.1")
                            Divider().background(Color.white.opacity(0.1)).padding(.horizontal)
                            InfoRow(title: "Environment", value: "Production-Mock")
                        }
                        .background(Color.cardDark)
                        .cornerRadius(12)
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
                    .buttonStyle(.interactive)
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.textSecondary)
            Spacer()
            Text(value)
                .foregroundColor(.textPrimary)
                .fontWeight(.medium)
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        AdminSettingsView()
    }
}

