import SwiftUI

struct CustomerTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CustomerHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            UsageOverviewView()
                .tabItem {
                    Label("Usage", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(2)
            
            CustomerProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(.primaryBlue)
    }
}

#Preview {
    CustomerTabView()
}



