import SwiftUI

struct AdminTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AdminDashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
                .tag(0)
            
            OutageManagementView()
                .tabItem {
                    Label("Outages", systemImage: "exclamationmark.triangle.fill")
                }
                .tag(1)
            
            SendNotificationView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(2)
            
            AdminProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(.primaryBlue)
    }
}

#Preview {
    AdminTabView()
}

