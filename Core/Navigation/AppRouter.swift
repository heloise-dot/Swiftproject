import SwiftUI

// Ensure this matches your actual User model name
// If you don't have one yet, uncomment the line below:
// struct User: Hashable { let id: UUID; var name: String }

enum AppRoute: Hashable {
    case login
    case roleSelection
    case register
    case customerMain
    case adminMain
    case adminDashboard
    case customerHome
    
    // Admin Sub-screens
    case areaManagement
    case editAreaStatus(Area)
    case systemOverview
    
    // Customer Sub-screens
    case areaStatus(Area)
    case outageList
    case outageDetail(Outage)
    case waterAvailability
    case waterMap
    case notificationDetail(NotificationItem)
    case waterTips
    case tipDetail(WaterTip)
    case helpCenter
    case contactSupport
    case customerProfile
    case editProfile
    case customerSettings
    case dailyUsage
    case weeklyUsage
    case monthlyUsage
    
    // Settings Sub-screens
    case changePassword
    case privacyPolicy
    case termsOfService
    case exportData
    case systemLogs
    
    // Admin Extras
    case createOutage
    case outageHistory
    case notificationHistory
    case sendNotification
    case adminProfile
    case adminSettings
    case pumpControl
    case tankLevels
    case waterSources
    case waterSourceDetail(WaterSource)
}

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var showForgotPassword = false
    @Published var currentUser: User? // Ensure 'User' is also Hashable

    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
 }

struct WaterTip: Identifiable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var category: String
    var impact: String
    var icon: String
    
    init(id: UUID = UUID(), title: String, description: String, category: String, impact: String, icon: String = "drop.fill") {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.impact = impact
        self.icon = icon
    }
}

// MARK: - Interactive Button Style
/// A button style that provides visual and haptic feedback
public struct InteractiveButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                }
            }
    }
}

public extension ButtonStyle where Self == InteractiveButtonStyle {
    public static var interactive: InteractiveButtonStyle { InteractiveButtonStyle() }
}

// MARK: - Navigation Bar Theme
/// Configures the global navigation bar appearance to remove glassmorphism
public struct NavigationBarTheme {
    public static func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.backgroundDark)
        
        // Premium Typography
        let titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        let largeTitleFont = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.textPrimary),
            .font: titleFont
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.textPrimary),
            .font: largeTitleFont
        ]
        
        // Remove bottom shadow/line for a seamless look
        appearance.shadowColor = .clear
        
        // Back Button Styling
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.primaryBlue)]
        appearance.backButtonAppearance = backButtonAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        // Set global tint color
        UINavigationBar.appearance().tintColor = UIColor(Color.primaryBlue)
    }
}

// MARK: - Settings Support Views

public struct ChangePasswordView: View {
    public init() {}
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
    public var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Current Password")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        SecureField("Enter current password", text: $currentPassword)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("New Password")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        SecureField("Enter new password", text: $newPassword)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm New Password")
                            .font(.subheadline)
                            .foregroundColor(.textSecondary)
                        SecureField("Confirm new password", text: $confirmPassword)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                            .foregroundColor(.textPrimary)
                    }
                    
                    Button(action: {}) {
                        Text("Update Password")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryBlue)
                            .cornerRadius(16)
                    }
                    .buttonStyle(.interactive)
                }
                .padding()
            }
        }
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsContentView: View {
    let title: String
    let content: String
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(content)
                        .font(.body)
                        .foregroundColor(.textPrimary)
                        .lineSpacing(6)
                }
                .padding()
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

public struct PrivacyPolicyView: View {
    public init() {}
    public var body: some View {
        SettingsContentView(
            title: "Privacy Policy",
            content: "Your privacy is important to us. This policy explains how we collect, use, and protect your personal information when you use the Water Utility App...\n\n1. Data Collection: We collect information you provide during registration and usage data to improve our service.\n\n2. Data Usage: Your data is used to provide notifications, monitor water usage, and ensure system reliability.\n\n3. Data Protection: We implement industry-standard security measures to protect your data from unauthorized access."
        )
    }
}

public struct TermsOfServiceView: View {
    public init() {}
    public var body: some View {
        SettingsContentView(
            title: "Terms of Service",
            content: "By using the Water Utility App, you agree to the following terms and conditions...\n\n1. Acceptance of Terms: You agree to comply with all applicable local laws and regulations.\n\n2. Use License: Permission is granted to use this app for personal, non-commercial use related to water utility monitoring.\n\n3. Accuracy of Data: While we strive for accuracy, we cannot guarantee that all water usage data or status updates are 100% real-time or error-free."
        )
    }
}

public struct ExportDataView: View {
    public init() {}
    @State private var isExporting = false
    @State private var progress: Double = 0.0
    @State private var showSuccess = false
    
    public var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            VStack(spacing: 24) {
                if showSuccess {
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.green)
                        Text("Export Complete")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.textPrimary)
                        Text("Your report is ready to be shared.")
                            .foregroundColor(.textSecondary)
                    }
                    .transition(.scale)
                } else if isExporting {
                    VStack(spacing: 24) {
                        ProgressView(value: progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .primaryBlue))
                            .padding(.horizontal, 40)
                        Text("Generating Report... \(Int(progress * 100))%")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                    }
                } else {
                    Image(systemName: "arrow.down.doc.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.primaryBlue)
                    
                    Text("Export System Data")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)
                    
                    Text("Generate a comprehensive report of water usage, outage history, and system status in CSV or PDF format.")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        Button(action: { startExport() }) {
                            HStack {
                                Image(systemName: "tablecells")
                                Text("Export as CSV")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                        }
                        .buttonStyle(.interactive)
                        
                        Button(action: { startExport() }) {
                            HStack {
                                Image(systemName: "doc.richtext")
                                Text("Export as PDF")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cardDark)
                            .cornerRadius(12)
                        }
                        .buttonStyle(.interactive)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Export Data")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startExport() {
        withAnimation { isExporting = true }
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            progress += 0.05
            if progress >= 1.0 {
                timer.invalidate()
                withAnimation {
                    isExporting = false
                    showSuccess = true
                }
            }
        }
    }
}

public struct SystemLogsView: View {
    public init() {}
    
    let mockLogs = [
        ("Database sync completed", "System", "SUCCESS"),
        ("New outage reported: Kigali West", "Alert", "INFO"),
        ("Emergency maintenance scheduled", "Maintenance", "WARNING"),
        ("Automated backup successful", "Backup", "SUCCESS"),
        ("User 'admin_kigali' logged in", "Security", "INFO"),
        ("Pump #4 pressure threshold reached", "Hardware", "WARNING"),
        ("Sensor update deployed v2.1", "Update", "SUCCESS"),
        ("Cloud synchronization paused", "Network", "WARNING"),
        ("Usage report generated", "Report", "SUCCESS"),
        ("System diagnostic check", "System", "SUCCESS")
    ]
    
    public var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<mockLogs.count, id: \.self) { i in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(mockLogs[i].0) - \(Date().addingTimeInterval(Double(-i * 3600)).formatted(date: .abbreviated, time: .shortened))")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.textPrimary)
                                Text("Component: \(mockLogs[i].1)")
                                    .font(.caption)
                                    .foregroundColor(.textSecondary)
                            }
                            Spacer()
                            Text(mockLogs[i].2)
                                .font(.system(size: 10, weight: .bold))
                                .padding(4)
                                .background(statusColor(mockLogs[i].2).opacity(0.2))
                                .foregroundColor(statusColor(mockLogs[i].2))
                                .cornerRadius(4)
                        }
                        .padding()
                        .background(Color.cardDark)
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("System Logs")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func statusColor(_ status: String) -> Color {
        switch status {
        case "SUCCESS": return .green
        case "WARNING": return .orange
        case "INFO": return .blue
        default: return .gray
        }
    }
}
